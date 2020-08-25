module Posts exposing (main)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href)
import Layouts exposing (pageLayout)
import Post


main : Elmstatic.Layout
main =
    let
        postItem post =
            div []
                [ a [ href ("/" ++ post.link) ] [ h3 [] [ text post.title ] ]
                , Post.metadataHtml post
                ]

        postListContent posts =
            if List.isEmpty posts then
                [ text "No posts yet!" ]

            else
                List.map postItem posts

        sortPosts posts =
            List.sortBy .date posts
                |> List.reverse
    in
    Elmstatic.layout Elmstatic.decodePostList <|
        \content ->
            pageLayout content.title <| Ok <| postListContent <| sortPosts content.posts
