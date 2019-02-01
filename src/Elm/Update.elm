module Update exposing (update)

import Model exposing (..)
import Model.Entity as Entity exposing (Entity(..))
import Point
import Reference


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select ref ->
            ( { model | ref = Just ref }
            , Cmd.none
            )

        Drag p ->
            let
                updatedReference =
                    model.ref
                        |> Maybe.map (Reference.modify <| Entity.move p)
            in
            ( { model
                | entities =
                    updatedReference
                        |> Maybe.map Reference.root
                        |> Maybe.withDefault model.entities
                , ref = updatedReference
              }
            , Cmd.none
            )

        End ->
            ( { model | ref = Nothing }
            , Cmd.none
            )
