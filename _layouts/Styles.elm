module Styles exposing (styles)

import Css exposing (..)
import Css.Global exposing (..)
import Css.Media as Media exposing (..)
import Html exposing (Html)
import Html.Styled


typographyTemplates =
    let
        serifFam =
            fontFamilies [ "Crimson Pro", "Times New Roman", .value serif ]

        sansFam =
            fontFamilies [ "Red Hat Text", "Arial", "Helvetica", .value sansSerif ]

        sansFamHeader =
            fontFamilies [ "Livvic", "Arial", "Helvetica", .value sansSerif ]
    in
    { default =
        [ fontSize <| px 18
        , Css.color <| hex "333333"
        , lineHeight <| Css.em 1.4
        , sansFam
        ]
    , serif1 =
        [ lineHeight <| Css.rem 1.4
        , fontSize <| rem 1
        , serifFam
        ]
    , serif4 =
        [ lineHeight <| Css.rem 1.4
        , fontSize <| rem 1.8
        , serifFam
        ]
    , sans1 =
        [ fontSize <| rem 1
        , sansFam
        , lineHeight <| Css.rem 1.4
        ]
    , sans2 =
        [ fontSize <| rem 1.1
        , sansFamHeader
        , lineHeight <| Css.rem 1.4
        ]
    , sans3 =
        [ fontSize <| rem 1.2
        , sansFamHeader
        , lineHeight <| Css.rem 1.4
        ]
    , sans4 =
        [ fontSize <| rem 1.8
        , sansFamHeader
        , lineHeight <| Css.rem 1.4
        ]
    , sans5 =
        [ fontSize <| rem 2.3
        , sansFamHeader
        , lineHeight <| Css.rem 1.4
        ]
    , fontCode =
        [ fontFamilies [ "mononoki", "JetBrains Mono", .value monospace ]
        , fontSize <| Css.rem 0.82
        , lineHeight <| Css.rem 1.2
        ]
    }


withTypography typeStyle attrs =
    typeStyle typographyTemplates ++ attrs


resets =
    [ Css.Global.pre
        [ descendants
            [ code [ important <| overflowX Css.scroll ] ]
        ]
    ]


elements =
    let
        color =
            [ 50, 67, 84 ]
    in
    [ a
        [ Css.color <| rgba 50 67 84 1
        , textDecoration3 underline dashed <| rgba 50 67 84 0.3
        , property "text-underline-offset" "0.15em"
        , property "text-decoration-thickness" "0.1em"
        ]
    , li
        []
    ]


getHeaderMargins n =
    let
        x =
            case n of
                1 ->
                    2.0202

                2 ->
                    1.61616

                3 ->
                    1.21212

                4 ->
                    0.80808

                _ ->
                    0.60606
    in
    [ marginBottom <| rem x
    , marginTop <| rem x
    ]


typography =
    [ h1 <| withTypography .sans5 <| getHeaderMargins 1
    , h2 <| withTypography .serif4 <| getHeaderMargins 2
    , h3 <| withTypography .sans3 <| getHeaderMargins 3
    , h4 <| withTypography .sans2 <| getHeaderMargins 4
    , each [ h5, h6 ] <| withTypography .sans1 <| getHeaderMargins 5
    , p <| withTypography .sans1 [ margin3 auto auto (rem 1) ]
    , li <| withTypography .sans1 [ margin4 (rem 0.2) auto (rem 0.5) auto ]
    , Css.Global.small [ fontSize <| pct 65 ]
    , code typographyTemplates.fontCode
    ]


layouts =
    let
        wideScreen =
            withMedia [ only screen [ Media.minWidth <| Css.px 600 ] ]
    in
    [ html <|
        withTypography .default
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex "eeeeee"
            ]
    , article
        [ paddingLeft <| Css.em 0.5
        , paddingTop <| Css.em 0.5
        ]
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
            , li <|
                withTypography .sans2
                    [ display inlineBlock
                    , marginRight <| Css.em 1
                    ]
            ]
        , wideScreen [ marginTop <| px 0, padding <| px 0, textAlign right ]
        ]
    , class "content"
        [ Css.maxWidth <| vw 100
        ]
    , class "post-list-item"
        [ paddingLeft <| Css.em 0.5
        , paddingTop <| Css.em 0.5
        , displayFlex
        , justifyContent spaceBetween
        , alignItems flexEnd
        , flexWrap wrap
        ]
    , class "post-metadata" <|
        withTypography .serif1
            [ alignSelf flexEnd
            , textAlign right
            , flexGrow <| num 100
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
            ++ getHeaderMargins 4
    ]


styles : Html msg
styles =
    Html.Styled.toUnstyled <|
        global <|
            resets
                ++ typography
                ++ elements
                ++ layouts
