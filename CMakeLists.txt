cmake_minimum_required(VERSION 3.16)
project(CosmicAdventure VERSION 1.0.0 LANGUAGES CXX)

# Set default build type if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Set QML module path
set(CMAKE_PREFIX_PATH "D:/Install/Qt/6.8.3/mingw_64")

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Gui
    Quick
    QuickControls2
    QuickTemplates2
    Multimedia
)

set(PROJECT_SOURCES
    src/main.cpp
    qml/main.qml
    qml/components/MainMenu.qml
    qml/components/SpaceHero.qml
    qml/components/SpaceEnemy.qml
    qml/components/PowerUp.qml
    qml/components/Laser.qml
    qml/components/Explosion.qml
    qml/components/ScorePopup.qml
    qml/components/GameMessage.qml
    qml/components/Level.qml
    qml/components/PauseMenu.qml
    qml/components/Settings.qml
    qml/components/GameOver.qml
    qml/components/Victory.qml
    qml/components/LevelSelect.qml
    qml/components/Credits.qml
    resources.qrc
)

add_executable(${PROJECT_NAME}
    ${PROJECT_SOURCES}
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::QuickTemplates2
    Qt6::Multimedia
)

# Set QML import paths
target_compile_definitions(${PROJECT_NAME} PRIVATE
    QT_QML_IMPORT_PATH="${CMAKE_CURRENT_SOURCE_DIR}/qml"
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.CosmicAdventure
    MACOSX_BUNDLE_BUNDLE_NAME CosmicAdventure
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    IOS_GUI_IDENTIFIER com.example.CosmicAdventure
)

# Install
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    BUNDLE DESTINATION .
    LIBRARY DESTINATION lib
)

# Deploy Qt dependencies
if(WIN32)
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Deploying Qt dependencies..."
        COMMAND ${Qt6Core_DIR}/../../../bin/windeployqt.exe
            --no-compiler-runtime
            --no-translations
            --no-system-d3d-compiler
            --qmldir ${CMAKE_CURRENT_SOURCE_DIR}/qml
            $<TARGET_FILE:${PROJECT_NAME}>
    )
endif() 