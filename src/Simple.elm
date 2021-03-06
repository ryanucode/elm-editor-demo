module Highlight exposing (..)

import Html exposing (..)
import Html.Lazy exposing (lazy)
import Html.Events as Event
import Html.Attributes as Attr exposing (class, id)

-- MAIN
main : Program Never Model Msg
main =program
    { init = (initModel, initCmd)
    , update = update
    , view = lazy view
    , subscriptions = subscriptions
    }

initModel : Model
initModel = ""

initCmd : Cmd Msg
initCmd = Cmd.none

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

-- VIEW
view : Model -> Html Msg
view model = node "main" []
    [ h1 [] [text "Code Editor"]
    , p [] [text "There is no interaction with codemirror or highligh.js in this example. It is just meant to give a gist of how the application should work. You can open the JS console and type in the editor to see extra debugging information."]
    , textarea [id "codemirror", Event.onInput UpdateCode] []
    , h1 [] [text "Code Viewer"]
    , pre [class "highlight"] 
        [code [class "html"] [text <| Debug.log "display" model]]
    ]

-- SUBS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
