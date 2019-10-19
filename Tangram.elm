module Tangram exposing
    ( Message
    , Model
    , initial
    , subscriptions
    , update
    , view
    )

import Browser.Events
import Html exposing (Html)
import Html.Attributes exposing (height, style, width)
import Math.Matrix4 exposing (Mat4, makeRotate, makeScale, makeTranslate, mul)
import Math.Vector3 exposing (Vec3, vec3)
import Tangram.Mesh as Mesh
import Tangram.Shader as Shader exposing (Attribute, Uniform, Varying)
import Tangram.Shape as Shape exposing (Position, Shape)
import Time exposing (Posix)
import WebGL exposing (Entity, Mesh)


type alias Message =
    Float


type alias Model =
    Float


shapes : List Shape
shapes =
    [ Shape.elm
    , Shape.elmBerlin
    ]


initial : Model
initial =
    0


subscriptions : Model -> Sub Message
subscriptions model =
    Browser.Events.onAnimationFrameDelta identity


update : Message -> Model -> ( Model, Cmd Message )
update time model =
    ( model + time * 0.0005
    , Cmd.none
    )


view : Model -> Html Message
view t =
    let
        shape =
            interpolate shapes t

        ratio =
            1280 / 720
    in
    WebGL.toHtml
        [ width 1280
        , height 720
        , style "display" "block"
        ]
        [ render ratio Mesh.parallelepiped colors.green (scaleMat 1) shape.parallelepiped t
        , render ratio Mesh.tetrahedron colors.orange (scaleMat 2) shape.orangeTetrahedron1 t
        , render ratio Mesh.cube colors.green (scaleMat 2) shape.cube t
        , render ratio Mesh.tetrahedron colors.orange (scaleMat 2) shape.orangeTetrahedron2 t
        , render ratio Mesh.tetrahedron colors.gray (scaleMat 4) shape.grayTetrahedron t
        , render ratio Mesh.tetrahedron colors.blue (scaleMat 4) shape.blueTetrahedron2 t
        , render ratio Mesh.tetrahedron colors.blue (scaleMat (sqrt 2 * 2)) shape.blueTetrahedron1 t
        ]


render : Float -> Mesh Attribute -> Vec3 -> Mat4 -> Position -> Float -> Entity
render ratio shape color scaleMat_ { rotateZ, rotateY, x, y, z } t =
    WebGL.entity
        Shader.vertex
        Shader.fragment
        shape
        (Uniform color (rotateMat rotateZ rotateY t) scaleMat_ (translateMat x (y + 1) z t) (camera ratio))


colors :
    { gray : Vec3
    , green : Vec3
    , orange : Vec3
    , blue : Vec3
    }
colors =
    { gray = vec3 0.353 0.388 0.47
    , green = vec3 0.514 0.784 0.2
    , orange = vec3 0.937 0.647 0
    , blue = vec3 0.372 0.706 0.792
    }


camera : Float -> Mat4
camera ratio =
    let
        eye =
            vec3 0 0 25

        center =
            vec3 0 0 0
    in
    mul (Math.Matrix4.makePerspective 45 ratio 0.01 100)
        (Math.Matrix4.makeLookAt eye center Math.Vector3.j)


f : Float -> Float
f t =
    clamp_ (cos t)


clamp_ : Float -> Float
clamp_ x =
    (clamp 0.2 0.8 (x ^ 2) - 0.2) / 0.6


interpolate : List Shape -> Float -> Shape
interpolate shapes_ t =
    let
        current =
            truncate (t / pi)

        shape1 =
            shapes_
                |> List.drop (modBy (List.length shapes_) current)
                |> List.head
                |> Maybe.withDefault Shape.default

        shape2 =
            shapes_
                |> List.drop (modBy (List.length shapes_) (current + 1))
                |> List.head
                |> Maybe.withDefault Shape.default

        d =
            clamp_ (sin ((t - toFloat current * pi) / 2))
    in
    Shape.morph d shape1 shape2


rotateMat : Float -> Float -> Float -> Mat4
rotateMat rotateZ rotateY t =
    makeRotate (rotateZ * pi / 180 * f t) (vec3 0 0 1)
        |> mul (makeRotate (rotateY * pi / 180 + 2 * (1 - f t)) (vec3 0 1 0))


scaleMat : Float -> Mat4
scaleMat s =
    makeScale (vec3 s s s)


translateMat : Float -> Float -> Float -> Float -> Mat4
translateMat x y z t =
    makeTranslate (vec3 (x / (f t * f t)) (y / (f t * f t)) (z / (f t * f t)))
