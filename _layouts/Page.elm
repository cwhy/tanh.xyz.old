module Page exposing (main)

import ElmMarkup
import Elmstatic
import Layouts exposing (pageLayout)


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePage <|
        \content ->
            pageLayout content.title <| ElmMarkup.markupToHtml content.content
