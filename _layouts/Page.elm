module Page exposing (footer, header, layout, main)

import ElmMarkup
import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (alt, attribute, class, href, src)
import Styles




header : List (Html Never)
header =
    [ div [ class "header-logo" ]
        [ img [ alt "tanh.xyz", src "/img/logo.svg", attribute "width" "100" ]
            []
        ]
    , div [ class "navigation" ]
        [ ul []
            [ li []
                [ a [ href "/posts" ]
                    [ text "Posts" ]
                ]
            , li []
                [ a [ href "/about" ]
                    [ text "About" ]
                ]
            , li []
                [ a [ href "/contact" ]
                    [ text "Contact" ]
                ]
            ]
        ]
    ]


footer : String -> Html Never
footer title =
    div [ class "footer" ]
        [ img
            [ alt title
            , src "/img/logo.svg"
            , attribute "style" "float: left; padding-top: 7px"
            , attribute "width" "75"
            ]
            []
        ]


layout : String -> Result String (List (Html Never)) -> Result String (List (Html Never))
layout title contentItems =
    case contentItems of
        Ok contentHtml ->
            Ok <|
                header
                    ++ [ div [ class "sidebar" ]
                            []
                       , div [ class "sidebar2" ]
                            []
                       , div [ class "content" ]
                            ([ h1 [] [ text title ] ] ++ contentHtml)
                       , footer title
                       , Elmstatic.stylesheet "/styles.css"
                       , Styles.styles
                       ]

        Err error ->
            Err error


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePage <|
        \content ->
            layout content.title <| ElmMarkup.markupToHtml content.content
