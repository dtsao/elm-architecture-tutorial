import Effects exposing (Never)
import StartApp
import RandomGif exposing (init, view, update)
import Task


app =
  StartApp.start
    { init = init "funny cats"
    , update = update
    , view = view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


