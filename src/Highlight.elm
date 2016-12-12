port module Highlight exposing (..)

import Html exposing (..)
import Html.Lazy exposing (lazy)
import Html.Events as Event
import Html.Attributes as Attr exposing (class, id)

-- PORTS

-- should be called called every code change to re-highlight updated content
port addSyntaxHighlighting : () -> Cmd msg

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
initModel = "<p class=\"test\">This is a test.</p>"

initCmd : Cmd Msg
initCmd = addSyntaxHighlighting ()

-- MODEL

type alias Model = String

-- UPDATE

type Msg
    = UpdateCode String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        UpdateCode code ->
            -- when the code is updated attempt to allow highlight.js to
            -- re-highlight the new content
            (Debug.log "got code" code, addSyntaxHighlighting ())

-- VIEW
view : Model -> Html Msg
view model = node "main" []
    [ h1 [] [text "Code Editor"]
    , p [] [text "This example fails when the user attempts to type in the code editor."]
    , textarea [id "codemirror", Event.onInput UpdateCode] [text initModel]
    , h1 [] [text "Code Viewer"]
    , pre [class "highlight"] 
        [code [class "html"] [text <| Debug.log "display" model]]
    ]

-- SUBS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
