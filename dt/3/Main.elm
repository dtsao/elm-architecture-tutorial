import CounterList exposing (initialModel, update, view)

import StartApp.Simple exposing (start)
import Html exposing (Html)

main : Signal Html
main =
    start 
    { model = initialModel
    , update = update
    , view = view
    }   



