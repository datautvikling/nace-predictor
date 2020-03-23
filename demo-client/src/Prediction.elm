module Prediction exposing (PredictionResult, getPrediction, viewPredictionResult)

import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode as JD
import Json.Encode as JE
import NaceCodes exposing (codeAndDescription)


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


getPrediction path resultType queryText =
    Http.post
        { url = path ++ "v1/prediction"
        , body = queryText |> queryTextEncoder |> Http.jsonBody
        , expect = Http.expectJson resultType predictionResultDecoder
        }


queryTextEncoder queryText =
    JE.object [ ( "text", JE.string queryText ) ]


predictionResultDecoder =
    JD.map2 PredictionResult
        (predictionDecoder |> JD.list |> JD.field "predictions")
        (predictionMetaInfoDecoder |> JD.field "meta")


predictionDecoder =
    JD.map2 Prediction
        (JD.field "code" JD.string)
        (JD.field "confidence" JD.float)


predictionMetaInfoDecoder =
    JD.map2 PredictionMetaInfo
        (JD.field "id" JD.string)
        (JD.field "model" JD.string)


viewPredictionResult result =
    let
        predictions =
            case result.predictions of
                [] ->
                    [ p [] [ text "No good predictions 😞" ] ]

                pred ->
                    List.map viewPrediction pred
    in
    div [] predictions


viewPrediction prediction =
    let
        formatCode =
            codeAndDescription >> text

        formatConfidence =
            (*) 100
                >> floor
                >> String.fromInt
                >> (\i -> " (" ++ i ++ "%)")
                >> text
    in
    div [ class "prediction" ]
        [ span [] [ formatCode prediction.code ]
        , span [] [ formatConfidence prediction.confidence ]
        ]
