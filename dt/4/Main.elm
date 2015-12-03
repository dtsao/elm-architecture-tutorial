import CounterList exposing (initialModel, update, view)
import StartApp.Simple as StartApp
import Html exposing (Html)

main : Signal Html
main =
    StartApp.start 
    { model = initialModel
    , view = view
    , update = update
    }