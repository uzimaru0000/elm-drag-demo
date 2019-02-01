module Model exposing (Model, Msg(..), init)

import Model.Entity exposing (..)
import Point exposing (..)
import Reference exposing (Reference)


type alias Model =
    { entities : List Entity
    , ref : Maybe (Reference Entity (List Entity))
    }


type Msg
    = Select (Reference Entity (List Entity))
    | Drag Point
    | End


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        [ Entity
            { pos = Point 100 100, size = Point 300 300 }
            (Note
                [ Entity
                    { pos = Point 20 20, size = Point 100 100 }
                    (Sticky "child")
                , Entity
                    { pos = Point 150 20, size = Point 100 100 }
                    (Sticky "child")
                ]
            )
        ]
        Nothing
    , Cmd.none
    )
