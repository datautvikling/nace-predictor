module Main exposing (..)

import Browser
import Debounce exposing (Debounce)
import Html exposing (Html, a, div, li, ol, p, span, text, textarea)
import Html.Attributes exposing (class, href, placeholder, target, value)
import Html.Events exposing (onInput)
import Http
import Json.Decode as JD
import Json.Encode as JE
import NaceCodes exposing (codeAndDescription)
import Result exposing (Result)


apiPath =
    "http://localhost:5000/api/"


debounceConfig : Debounce.Config Msg
debounceConfig =
    { strategy = Debounce.later 500
    , transform = DebounceMsg
    }



---- MODEL ----


type alias Model =
    { inputText : String
    , result : Response
    , debounce : Debounce String
    }


type Response
    = Loading
    | Message String
    | Success PredictionResult


type alias PredictionResult =
    { predictions : List Prediction
    , meta : PredictionMetaInfo
    }


type alias Prediction =
    { code : String
    , confidence : Float
    }


type alias PredictionMetaInfo =
    { id : String
    , model : String
    }


typeSomething =
    "Type something to get predictions!"


init : ( Model, Cmd Msg )
init =
    ( Model "" (Message typeSomething) Debounce.init, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | ChangedInput String
    | GotPrediction (Result Http.Error PredictionResult)
    | DebounceMsg Debounce.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangedInput "" ->
            ( { model | inputText = "", result = Message typeSomething }, Cmd.none )

        ChangedInput newInputText ->
            let
                ( debounce, cmd ) =
                    Debounce.push debounceConfig newInputText model.debounce
            in
            ( { model | inputText = newInputText, debounce = debounce, result = Loading }
            , cmd
            )

        DebounceMsg bouncedMsg ->
            let
                ( debounce, cmd ) =
                    Debounce.update
                        debounceConfig
                        (Debounce.takeLast getPrediction)
                        bouncedMsg
                        model.debounce
            in
            ( { model | debounce = debounce }, cmd )

        GotPrediction (Ok prediction) ->
            ( { model | result = Success prediction }, Cmd.none )

        GotPrediction (Err _) ->
            ( { model | result = Message "Couldn't contact the API. Try again?" }, Cmd.none )


getPrediction : String -> Cmd Msg
getPrediction queryText =
    Http.post
        { url = apiPath ++ "v1/prediction"
        , body = queryText |> queryTextEncoder |> Http.jsonBody
        , expect = Http.expectJson GotPrediction predictionResultDecoder
        }


queryTextEncoder queryText =
    JE.object [ ( "text", JE.string queryText ) ]


predictionResultDecoder : JD.Decoder PredictionResult
predictionResultDecoder =
    JD.map2 PredictionResult
        (predictionDecoder |> JD.list |> JD.field "predictions")
        (predictionMetaInfoDecoder |> JD.field "meta")


predictionDecoder : JD.Decoder Prediction
predictionDecoder =
    JD.map2 Prediction
        (JD.field "code" JD.string)
        (JD.field "confidence" JD.float)


predictionMetaInfoDecoder : JD.Decoder PredictionMetaInfo
predictionMetaInfoDecoder =
    JD.map2 PredictionMetaInfo
        (JD.field "id" JD.string)
        (JD.field "model" JD.string)



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ viewNavBar, viewTextArea model.inputText, viewResult model.result ]


viewTextArea : String -> Html Msg
viewTextArea inputText =
    textarea
        [ placeholder "Type or paste a text here!", value inputText, onInput ChangedInput ]
        []


viewNavBar : Html Msg
viewNavBar =
    ol []
        [ li
            [ class "floatLeft" ]
            [ a [] [ text "NACE Predictor" ] ]
        , li
            [ class "floatRight" ]
            [ a [ href apiPath, target "_blank" ] [ text "API" ] ]
        , li
            [ class "floatRight" ]
            [ a
                [ href "https://github.com/datautvikling/nace-predictor", target "_blank" ]
                [ text "Code" ]
            ]
        ]


viewResult : Response -> Html Msg
viewResult response =
    case response of
        Loading ->
            p [] [ text "Loading ..." ]

        Message msg ->
            p [] [ text msg ]

        Success prediction ->
            viewPredictionResult prediction


viewPredictionResult : PredictionResult -> Html Msg
viewPredictionResult result =
    div []
        (if List.isEmpty result.predictions then
            [ p [] [ text "No good predictions 😞" ] ]

         else
            List.map viewPrediction result.predictions
        )


viewPrediction : Prediction -> Html Msg
viewPrediction prediction =
    div [ class "prediction" ]
        [ span [] [ prediction.code |> codeAndDescription |> text ]
        , span []
            [ prediction.confidence
                |> (\f -> floor (f * 100))
                |> (\i ->
                        " ("
                            ++ String.fromInt i
                            ++ "%)"
                   )
                |> text
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
