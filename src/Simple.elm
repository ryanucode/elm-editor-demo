port module Simple exposing (..)

import Html exposing (..)
import Html.Lazy exposing (lazy)
import Html.Events as Event
import Html.Attributes as Attr exposing (class, id)

port addCodeMirror : () -> Cmd msg
port addSyntaxHighlighting : () -> Cmd msg

port codeMirrorChange : (String -> msg) -> Sub msg

main : Program Never Model Msg
main =program
    { init = (initModel, initCmd)
    , update = update
    , view = lazy view
    , subscriptions = subscriptions
    }

type alias Model = String

initModel : Model
initModel = ""

initCmd : Cmd Msg
initCmd = Cmd.batch [addCodeMirror (), addSyntaxHighlighting ()]

type Msg
    = UpdateCode String
    | AddCodeMirror
    | AddSyntaxHighlighting

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        UpdateCode code ->
            (Debug.log "got code" code, Cmd.none)
        AddCodeMirror ->
            (model, Cmd.none)
        AddSyntaxHighlighting ->
            (model, addSyntaxHighlighting ())

view : Model -> Html Msg
view model = node "main" []
    [ h1 [] [text "Code Editor"]
    , textarea [id "codemirror", Event.onInput UpdateCode] []
    , pre [class "highlight"] 
        [code [class "html"] [text <| Debug.log "display" model]]
    ]

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch
    [ codeMirrorChange UpdateCode
    ]
