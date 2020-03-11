module Main exposing (..)

import Browser
import Html exposing (Html, a, div, li, ol, span, text, textarea)
import Html.Attributes exposing (class, href, placeholder, target, value)
import Html.Events exposing (onInput)
import Http
import Json.Decode as JD
import Json.Encode as JE
import NaceCodes exposing (codeAndDescription)


apiPath =
    "http://localhost:5000/api/"



---- MODEL ----


type alias Model =
    { inputText : String
    , prediction : PredictionResult
    }


type alias PredictionResult =
    { predictions : List Prediction
    , meta : Maybe PredictionMetaInfo
    }


type alias Prediction =
    { code : String
    , confidence : Float
    }


type alias PredictionMetaInfo =
    { id : String
    , model : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" (PredictionResult [] Nothing), Cmd.none )



---- UPDATE ----


type Msg
    = ChangeInput String
    | GotPrediction (Result Http.Error PredictionResult)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeInput newInputText ->
            ( { model | inputText = newInputText }
            , getPrediction newInputText
            )

        GotPrediction result ->
            case result of
                Ok prediction ->
                    ( { model | prediction = prediction }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


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
        (predictionMetaInfoDecoder |> JD.maybe |> JD.field "meta")


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
        [ viewNavBar
        , viewTextArea model.inputText
        , viewPredictionResult model.prediction
        ]


viewTextArea : String -> Html Msg
viewTextArea inputText =
    textarea
        [ placeholder "Type or paste a text here!"
        , value inputText
        , onInput ChangeInput
        ]
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
                [ href "https://github.com/datautvikling/nace-predictor"
                , target "_blank"
                ]
                [ text "Code" ]
            ]
        ]


viewPredictionResult : PredictionResult -> Html Msg
viewPredictionResult result =
    div []
        (List.map viewPrediction result.predictions)


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
