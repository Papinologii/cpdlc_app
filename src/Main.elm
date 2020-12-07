module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Events
import Json.Decode as Decode


{-| -}
onEnter : msg -> Element.Attribute msg
onEnter msg =
    Element.htmlAttribute
        (Html.Events.on "keyup"
            (Decode.field "key" Decode.string
                |> Decode.andThen
                    (\key ->
                        if key == "Enter" then
                            Decode.succeed msg

                        else
                            Decode.fail "Not the enter key"
                    )
            )
        )


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }



-- Model


type alias Model =
    { text : String
    , enterPressed : Bool
    }


initialModel : Model
initialModel =
    { text = ""
    , enterPressed = False
    }


type Msg
    = UpdateText String
    | EnterWasPressed



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText txt ->
            { model | text = txt }

        EnterWasPressed ->
            { model | enterPressed = True, text = "" }



-- View


view : Model -> Html Msg
view model =
    Element.layout []
        (mainPageColumn model)


mainPageColumn : Model -> Element Msg
mainPageColumn model =
    column
        [ width fill
        , height fill
        , spacing 5
        , Background.color primaryColor
        ]
        [ header
        , filterRow model
        , middle
        ]


header : Element msg
header =
    row
        [ width fill
        , paddingXY 20 10
        , Background.color primaryColor
        , Font.color white
        ]
        [ el
            [ Font.bold ]
            (text "MUAC CPC")
        , el
            [ centerX
            , centerY
            ]
            (text "TUE 02 10:20:27")
        , el
            [ alignRight
            , Font.color orange
            , Font.bold
            ]
            (text "ATM001")
        ]


filterRow : Model -> Element Msg
filterRow model =
    row
        [ width fill
        , paddingXY 20 10
        , Background.color thirdColor
        , Font.color white
        , Font.bold
        , spacing 10
        ]
        [ createFilterButton
            "ALL"
        , createFilterButton
            "BRU"
        , createFilterButton
            "HAN"
        , createFilterButton
            "DECO"
        , el
            [ alignRight ]
            (Input.text
                [ centerX
                , centerY
                , width (px 200)
                , spacing 16
                , Font.color thirdColor
                , onEnter EnterWasPressed
                ]
                { onChange = UpdateText
                , label = Input.labelLeft [] (text "")
                , text = model.text
                , placeholder =
                    Just
                        (Input.placeholder []
                            (text "Search")
                        )
                }
            )
        , el
            [ alignRight
            , Font.color orange
            , Font.light
            ]
            (text "X")
        ]


createFilterButton : String -> Element msg
createFilterButton textValue =
    el
        [ alignLeft
        , Border.width 1
        , Border.rounded 5
        , paddingXY 3 3
        , Background.color (rgb255 112 112 112)
        , mouseOver [ Font.color orange ]
        , pointer
        ]
        (text textValue)


middle : Element msg
middle =
    row [ height fill, width fill ]
        [ sidebar
        , content
        ]


sidebar : Element msg
sidebar =
    column
        [ height fill
        , paddingXY 15 10
        , spacing 15
        , Font.size 20
        , Font.color white
        , Background.color thirdColor
        ]
        [ el
            [ width fill
            , Background.color secondaryColor
            , Font.color orange
            , Font.bold
            ]
            (el [ centerX ] (text "None"))
        , text "EZY123"
        , text "KLM456"
        , text "AFR789"
        ]


content : Element msg
content =
    column
        [ width fill
        , height fill
        ]
        [ messageListRow
        , selectMessagePartsRow
        , inputMessageTextRow
        ]


messageListRow : Element msg
messageListRow =
    row
        [ width fill
        , height (fillPortion 2)
        , Font.color white
        ]
        [ row
            [ width (fillPortion 3)
            , height fill
            , explain Debug.todo
            ]
            [ el
                [ centerX
                , centerY
                ]
                (text "Message List Row")
            ]
        , row
            [ width (fillPortion 1)
            , height fill
            , explain Debug.todo
            ]
            [ el
                [ centerX
                , centerY
                ]
                (text "Map")
            ]
        ]


selectMessagePartsRow : Element msg
selectMessagePartsRow =
    row
        [ width fill
        , height (fillPortion 4)
        , Font.color white
        , explain Debug.todo
        ]
        [ el
            [ centerX
            , centerY
            ]
            (text "Select Message Parts Row")
        ]


inputMessageTextRow : Element msg
inputMessageTextRow =
    row
        [ width fill
        , height (fillPortion 1)
        , Font.color white
        , explain Debug.todo
        ]
        [ el
            [ centerX
            , centerY
            ]
            (text "InputMessage Text Row")
        ]


primaryColor : Color
primaryColor =
    rgb255 3 10 17


secondaryColor : Color
secondaryColor =
    rgb255 1 53 51


thirdColor : Color
thirdColor =
    rgba255 0 46 46 78.0


orange : Color
orange =
    rgb255 198 125 52


gray : Color
gray =
    rgb255 172 221 216


darkGray : Color
darkGray =
    rgb255 112 112 112


white : Color
white =
    rgb255 255 255 255


footer : Element msg
footer =
    text "Footer"
