import CounterPairPair exposing (update, view, model0)
import StartApp.Simple as StartApp

import Html

main : Signal Html.Html
main = 
    StartApp.start 
    { model = model0
    , view = view
    , update = update
    }
