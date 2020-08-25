module Styles exposing (styles)

import Css exposing (..)
import Css.Global exposing (..)
import Css.Media as Media exposing (..)
import Html exposing (Html)
import Html.Styled


linkColor =
    "324354"


styles : Html msg
styles =
    let
        wideScreen =
            withMedia [ only screen [ Media.minWidth <| Css.px 600 ] ]

        codeStyle =
            [ fontFamilies [ "Fira Code", .value monospace ]
            , fontSize <| Css.em 0.7
            ]
    in
    global
        [ body
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex "ffffff"
            , Css.color <| hex "333333"
            , fontFamilies [ "Crimson Pro", "Times New Roman", .value serif ]
            , fontSize <| px 18
            , lineHeight <| Css.em 1.4
            ]
        , a
            [ Css.color <| hex linkColor
            , textDecoration2 underline dashed
            , property "text-decoration-thickness" "0.1rem"
            ]
        , code codeStyle
        , Css.Global.pre
            [ descendants
                [ code [ important <| overflowX Css.scroll ] ]
            ]
        , each [ h1, h2, h3, h4, h5, h6 ]
            [ fontFamilies [ "Livvic", "Arial", "Helvetica", .value sansSerif ]
            , lineHeight <| Css.em 1.1
            ]
        , h1 [ fontSize <| Css.em 2.3, marginBottom <| rem 2.0202 ]
        , h2 [ fontSize <| Css.em 1.8, marginBottom <| rem 1.61616 ]
        , h3 [ fontSize <| Css.em 1.2, marginBottom <| rem 1.21212 ]
        , h4 [ fontSize <| Css.em 1.1, marginBottom <| rem 0.80808 ]
        , each [ h5, h6 ] [ fontSize <| Css.em 1.0, marginBottom <| rem 0.60606 ]
        , p [ margin3 auto auto (rem 1.5) ]
        , Css.Global.small [ fontSize <| pct 65 ]
        , class "header-text"
            [ paddingLeft <| rem 2
            , textAlign center
            , wideScreen [ textAlign left ]
            ]
        , class "navigation"
            [ textAlign center
            , padding <| px 10
            , marginTop <| px -20
            , descendants
                [ ul
                    [ margin <| px 0
                    , padding <| px 0
                    , wideScreen [ lineHeight <| px 100 ]
                    ]
                , li
                    [ display inlineBlock
                    , marginRight <| px 20
                    ]
                ]
            , wideScreen [ marginTop <| px 0, padding <| px 0, textAlign right ]
            ]
        , class "content" [ Css.maxWidth <| vw 100 ]
        , class "post-metadata"
            [ marginTop <| Css.em -0.5
            , marginBottom <| Css.em 2.0
            , descendants
                [ each [ a, span ]
                    [ display inlineBlock
                    , marginRight <| px 5
                    ]
                , a
                    [ border3 (px 1) solid (hex "e0e0e0")
                    , borderRadius <| px 3
                    , paddingLeft <| px 5
                    , paddingRight <| px 5
                    ]
                ]
            ]
        ]
        |> Html.Styled.toUnstyled
