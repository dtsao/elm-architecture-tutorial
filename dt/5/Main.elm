import StartApp
import RandomGif exposing (init, update, view)
import Effects exposing (Never)
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
