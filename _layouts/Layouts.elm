module Layouts exposing (pageLayout)

import Elements exposing (logo)
import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (alt, attribute, class, href, src)
import Styles


header : List (Html Never)
header =
    [ div [ class "header-text" ]
        [ logo
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


pageLayout : String -> Result String (List (Html Never)) -> Result String (List (Html Never))
pageLayout title contentItems =
    case contentItems of
        Ok contentHtml ->
            Ok <|
                header
                    ++ [ div [ class "sidebar" ]
                            []
                       , div [ class "sidebar2" ]
                            []
                       , div [ class "content" ]
                            ([ h2 [] [ text title ] ] ++ contentHtml)
                       , Elmstatic.stylesheet "/fonts/font.css"
                       , Elmstatic.stylesheet "/styles.css"
                       , Styles.styles
                       ]

        Err error ->
            Err error
