port module Codemirror exposing (..)

import Html exposing (..)
import Html.Lazy exposing (lazy)
import Html.Events as Event
import Html.Attributes as Attr exposing (class, id)

-- PORTS

-- called only once at program start
port addCodeMirror : () -> Cmd msg
-- called by code mirror when the user changes its content
port codeMirrorChange : (String -> msg) -> Sub msg

-- MAIN
main : Program Never Model Msg
main =program
    { init = (initModel, initCmd)
    , update = update
    -- have attempted to use both normal Html and Html.Lazy
    -- both produce similar results despite Lazy's reduced DOM manipulations
    , view = lazy view
    , subscriptions = subscriptions
    }

initModel : Model
initModel = ""

-- after elm starts let other libraries bind to its DOM
initCmd : Cmd Msg
initCmd = Cmd.batch [addCodeMirror ()]

-- MODEL

type alias Model = String

-- UPDATE

type Msg
    = UpdateCode String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        UpdateCode code ->
            (Debug.log "got code" code, Cmd.none)
            --(Debug.log "got code" code, addSyntaxHighlighting)

-- VIEW
view : Model -> Html Msg
view model = node "main" []
    [ h1 [] [text "Code Editor"]
    , p [] [text "Type in the code editor and open the console to see the error."]
    , textarea [id "codemirror", Event.onInput UpdateCode] []
    , h1 [] [text "Code Viewer"]
    , p [] [text "The highlighted code does not appear below here as it should."]
    , pre [class "highlight"] 
        [code [class "html"] [text <| Debug.log "display" model]]
    ]

-- SUBS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch
    [ codeMirrorChange UpdateCode
    ]
