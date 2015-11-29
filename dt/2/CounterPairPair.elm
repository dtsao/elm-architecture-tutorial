module CounterPairPair where

import CounterPair
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)

-- MODEL
type alias Model =
    { leftCounters : CounterPair.Model
    , rightCounters : CounterPair.Model
    }

model0 : Model
model0 = 
    let 
        init = CounterPair.init 0 0
    in
        { leftCounters = init
        , rightCounters = init
        }      

-- UPDATE
type Action = NoOp | Left CounterPair.Action | Right CounterPair.Action


update : Action -> Model -> Model
update action model =
    case action of
        NoOp -> model
        Left act ->
            { model | leftCounters = CounterPair.update act model.leftCounters}

        Right act ->
            { model | rightCounters = CounterPair.update act model.rightCounters}



-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div 
        [ ] 
        [ div 
            [ inLine ]
            [ CounterPair.view (Signal.forwardTo address Left) model.leftCounters]
        , div
            [ inLine ]
            [ CounterPair.view (Signal.forwardTo address Right) model.rightCounters ]
        ]


inLine : Html.Attribute
inLine = 
    style [("display", "inline-block")]
