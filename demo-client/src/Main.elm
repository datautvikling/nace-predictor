module Main exposing (..)

import Browser
import Debounce exposing (Debounce)
import Html exposing (Html, a, div, li, ol, p, text, textarea)
import Html.Attributes exposing (class, href, placeholder, target, value)
import Html.Events exposing (onInput)
import Http
import Prediction exposing (PredictionResult, getPrediction, viewPredictionResult)
import Result exposing (Result)


apiPath =
    "http://localhost:5000/api/"


debounceConfig : Debounce.Config Msg
debounceConfig =
    { strategy = Debounce.later 500
    , transform = DebounceMsg
    }


type alias Model =
    { inputText : String
    , response : Response
    , debounce : Debounce String
    }


type Response
    = Loading
    | Message String
    | Success PredictionResult


typeSomething =
    Message "Type something to get predictions!"


init : ( Model, Cmd Msg )
init =
    ( Model "" typeSomething Debounce.init, Cmd.none )


type Msg
    = ChangedInput String
    | GotPrediction (Result Http.Error PredictionResult)
    | DebounceMsg Debounce.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedInput "" ->
            ( { model | inputText = "", response = typeSomething }, Cmd.none )

        ChangedInput newInputText ->
            let
                ( debounce, cmd ) =
                    Debounce.push debounceConfig newInputText model.debounce
            in
            ( { model | inputText = newInputText, debounce = debounce, response = Loading }
            , cmd
            )

        DebounceMsg bouncedMsg ->
            let
                ( debounce, cmd ) =
                    Debounce.update
                        debounceConfig
                        (Debounce.takeLast (getPrediction apiPath GotPrediction))
                        bouncedMsg
                        model.debounce
            in
            ( { model | debounce = debounce }, cmd )

        GotPrediction (Ok prediction) ->
            ( { model | response = Success prediction }, Cmd.none )

        GotPrediction (Err _) ->
            ( { model | response = Message "Couldn't contact the API. Try again?" }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ viewNavBar, viewTextArea model.inputText, viewResult model.response ]


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


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
