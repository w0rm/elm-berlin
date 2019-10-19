module Tangram.Shape exposing
    ( Position
    , Shape
    , default
    , elm
    , elmBerlin
    , morph
    )


type alias Position =
    { rotateZ : Float
    , rotateY : Float
    , x : Float
    , y : Float
    , z : Float
    }


type alias Shape =
    { parallelepiped : Position
    , orangeTetrahedron1 : Position
    , orangeTetrahedron2 : Position
    , cube : Position
    , grayTetrahedron : Position
    , blueTetrahedron1 : Position
    , blueTetrahedron2 : Position
    }


sqrt2 : Float
sqrt2 =
    sqrt 2


sqrtsqrt2 : Float
sqrtsqrt2 =
    sqrt sqrt2


defaultPosition : Position
defaultPosition =
    Position 0 0 0 0 0


default : Shape
default =
    Shape
        defaultPosition
        defaultPosition
        defaultPosition
        defaultPosition
        defaultPosition
        defaultPosition
        defaultPosition


elm : Shape
elm =
    { parallelepiped = Position 0 0 -1 3 0
    , orangeTetrahedron1 = Position 90 0 0 2 0.01
    , orangeTetrahedron2 = Position 0 0 4 -2 0
    , cube = Position 0 0 2 0 0
    , grayTetrahedron = Position 180 0 -4 0 0
    , blueTetrahedron1 = Position -135 0 2 2 0
    , blueTetrahedron2 = Position -90 0 0 -4 0
    }


elmBerlin : Shape
elmBerlin =
    { parallelepiped = Position 45 180 (3 - sqrt2) -2 -2
    , orangeTetrahedron1 = Position 45 0 -4 (sqrt2 - 6) 0.01
    , orangeTetrahedron2 = Position 45 0 (10 - sqrt2 * 3) 2 0
    , cube = Position 45 0 3 2 0
    , grayTetrahedron = Position -45 0 (3 - sqrt2 * 3) (2 - sqrt2) 0
    , blueTetrahedron1 = Position 135 0 (1 - sqrt2) sqrt2 0
    , blueTetrahedron2 = Position 0.0 0 -4 (sqrt2 - 2) 0
    }


morphValue : Float -> Float -> Float -> Float
morphValue d v1 v2 =
    v1 + (v2 - v1) * d


morphPosition : Float -> Position -> Position -> Position
morphPosition d p1 p2 =
    Position
        (morphValue d p1.rotateZ p2.rotateZ)
        (morphValue d p1.rotateY p2.rotateY)
        (morphValue d p1.x p2.x)
        (morphValue d p1.y p2.y)
        (morphValue d p1.z p2.z)


morph : Float -> Shape -> Shape -> Shape
morph d s1 s2 =
    { parallelepiped = morphPosition d s1.parallelepiped s2.parallelepiped
    , orangeTetrahedron1 = morphPosition d s1.orangeTetrahedron1 s2.orangeTetrahedron1
    , orangeTetrahedron2 = morphPosition d s1.orangeTetrahedron2 s2.orangeTetrahedron2
    , cube = morphPosition d s1.cube s2.cube
    , grayTetrahedron = morphPosition d s1.grayTetrahedron s2.grayTetrahedron
    , blueTetrahedron1 = morphPosition d s1.blueTetrahedron1 s2.blueTetrahedron1
    , blueTetrahedron2 = morphPosition d s1.blueTetrahedron2 s2.blueTetrahedron2
    }
