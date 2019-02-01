module Model.Entity exposing (Content(..), Entity(..), Transform, move)

import Point exposing (Point)
import Reference


type Entity
    = Entity Transform Content


type Content
    = Note (List Entity)
    | Sticky String


type alias Transform =
    { pos : Point
    , size : Point
    }


move : Point -> Entity -> Entity
move movement (Entity ({ pos } as transform) content) =
    Entity { transform | pos = Point.add pos movement } content
