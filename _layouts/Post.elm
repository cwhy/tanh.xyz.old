module Post exposing (main, metadataHtml)

import ElmMarkup
import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Layouts exposing (pageLayout)


tagsToHtml : List String -> List (Html Never)
tagsToHtml tags =
    let
        tagLink tag =
            "/tags/" ++ String.toLower tag

        linkify tag =
            a [ href <| tagLink tag ] [ text tag ]
    in
    List.map linkify tags


metadataHtml : { a | date : String, tags : List String } -> Html Never
metadataHtml post =
    div [ class "post-metadata" ]
        ([ span [] [ text post.date ]
         , span [] [ text "•" ]
         ]
            ++ tagsToHtml post.tags
        )


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePost <|
        \content ->
            case ElmMarkup.markupToHtml content.content of
                Ok html ->
                    pageLayout content.title <|
                        Ok (metadataHtml content :: html)

                Err error ->
                    Err error
