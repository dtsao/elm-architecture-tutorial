module CounterList where

import Counter
import Html exposing (..)
import Html.Events exposing (onClick)


-- Model
type alias Model =
    { counters : List (ID, Counter.Model)
    , nextID: ID
    }

type alias ID = Int


initialModel : Model
initialModel =
    { counters = []
    , nextID = 1
    }


-- UPDATE
type Action
    = Insert
    | Remove
    | Modify ID Counter.Action


update : Action -> Model -> Model
update action model =
    case action of
        Insert ->
            let newCounter = (model.nextID, Counter.init 0)
                newCounters = model.counters ++ [ newCounter ]
            in
                { model |
                counters = newCounters
                , nextID = model.nextID + 1
                }

        Remove ->
            { model | counters = List.drop 1 model.counters }

        Modify id counterAction ->
            let updateCounter (counterID, counterModel) =
                if counterID == id
                    then (counterID, Counter.update counterAction counterModel)
                    else (counterID, counterModel)
            in
                { model | counters = List.map updateCounter model.counters }

-- VIEW
view : Signal.Address Action -> Model -> Html
view address model =
    let
        counters = List.map (viewCounter address) model.counters
        remove = button [onClick address Remove ] [ text "Remove" ]
        add = button [ onClick address Insert ] [ text "Add" ]
    in
        div [] ([ remove, add ] ++ counters)


viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id, model) =
    --Counter.view (Signal.forwardTo address (Modify id)) model
    Counter.view (Signal.forwardTo address (Modify id) model
    --if missing closing paren as in line above, causes compiler error below
    -- which didn't help me to locate the problem.
{-Detected errors in 1 module.
-- SYNTAX PROBLEM ------------------------------------------ .\.\CounterList.elm

I need whitespace, but got stuck on what looks like a new declaration. You are
either missing some stuff in the declaration above or just need to add some
spaces here:


I am looking for one of the following things:

    whitespace

-}