module Point exposing (Point, add, decoder)

import Json.Decode as JD


type alias Point =
    { x : Int
    , y : Int
    }


decoder : ( List String, List String ) -> JD.Decoder Point
decoder ( x, y ) =
    JD.map2 Point
        (JD.at x JD.int)
        (JD.at y JD.int)


add : Point -> Point -> Point
add p1 p2 =
    { x = p1.x + p2.x, y = p1.y + p2.y }
