-- elm 0.17.1


module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import KnowThen.Login as Login
import KnowThen.LeaderBoard as LeaderBoard


-- model


type alias Model =
    { page : Page
    , leaderBoard : LeaderBoard.Model
    , login : Login.Model
    }


initModel : Model
initModel =
    { page = LeaderBoardPage
    , login = Login.initModel
    , leaderBoard = LeaderBoard.initModel
    }


type Page
    = LeaderBoardPage
    | LoginPage



-- update


type Msg
    = ChangePage Page
    | LeaderBoardMsg LeaderBoard.Msg
    | LoginMsg Login.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePage page ->
            { model
                | page = page
            }

        LeaderBoardMsg lbMsg ->
            { model
                | leaderBoard =
                    LeaderBoard.update lbMsg model.leaderBoard
            }

        LoginMsg loginMsg ->
            { model
                | login =
                    Login.update loginMsg model.login
            }



-- view


view : Model -> Html Msg
view model =
    let
        page =
            case model.page of
                LeaderBoardPage ->
                    App.map LeaderBoardMsg
                        (LeaderBoard.view model.leaderBoard)

                LoginPage ->
                    App.map LoginMsg
                        (Login.view model.login)
    in
        div []
            [ div []
                [ a
                    [ href "#"
                    , onClick (ChangePage LeaderBoardPage)
                    ]
                    [ text "LeaderBoard Page" ]
                , span [] [ text " | " ]
                , a
                    [ href "#"
                    , onClick (ChangePage LoginPage)
                    ]
                    [ text "Login Page" ]
                ]
            , hr [] []
            , page
            ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
