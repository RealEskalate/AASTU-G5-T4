package controllers

import (
    "A2SVHUB/internal/domain"
    "context"
    "fmt"
    "strconv"

    "github.com/gin-gonic/gin"
)

type TrackController struct {
    TrackUseCase domain.TrackUseCase
}

func NewTrackController(tuc domain.TrackUseCase) *TrackController {
    return &TrackController{
        TrackUseCase: tuc,
    }
}

func (tc TrackController) GetAllTracks(c *gin.Context) {
    tracks, err := tc.TrackUseCase.GetAllTracks(context.TODO())
    if err != nil {
        c.JSON(500, gin.H{
            "details": "Something went wrong",
        })
    } else {
        c.JSON(200, gin.H{
            "tracks": tracks,
        })
    }
}

func (tc TrackController) CreateTrack(c *gin.Context) {
    var track domain.Track
    if err := c.ShouldBindJSON(&track); err != nil {
        c.JSON(400, gin.H{
            "detail": "invalid request body",
        })
        return
    }

    createdTrack, err := tc.TrackUseCase.CreateTrack(context.TODO(), track)
    if err != nil {
        c.JSON(500, gin.H{
            "detail": "Failed to create track",
        })
    } else {
        c.JSON(201, gin.H{
            "track": createdTrack,
        })
    }
}

func (tc TrackController) GetTrackByID(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }
    track, err := tc.TrackUseCase.FindTrackByID(context.TODO(), idInt)
    if err != nil {
        c.JSON(404, gin.H{
            "detail": "Track not found",
        })
    } else {
        c.JSON(200, gin.H{
            "track": track,
        })
    }
}

func (tc TrackController) GetTracksByName(c *gin.Context) {
    name := c.Query("name")
    if name == "" {
        c.JSON(404, gin.H{
            "detail": "name is required",
        })
        return
    }
    tracks, err := tc.TrackUseCase.FindTracksByName(context.TODO(), name)
    if err != nil {
        c.JSON(404, gin.H{
            "detail": "Tracks not found",
        })
    } else {
        c.JSON(200, gin.H{
            "tracks": tracks,
        })
    }
}

func (tc TrackController) UpdateTrack(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }

    var track domain.Track
    if err := c.ShouldBindJSON(&track); err != nil {
        c.JSON(400, gin.H{
            "detail": "invalid request body",
        })
        return
    }
    track.ID = idInt

    updatedTrack, err := tc.TrackUseCase.UpdateTrack(context.TODO(), track)
    if err != nil {
        c.JSON(500, gin.H{
            "detail": "Failed to update track",
        })
    } else {
        c.JSON(200, gin.H{
            "track": updatedTrack,
        })
    }
}

func (tc TrackController) DeleteTrack(c *gin.Context) {
    id := c.Param("id")
    idInt, err := strconv.Atoi(id)
    if err != nil {
        c.JSON(400, gin.H{
            "detail": "Invalid ID format",
        })
        return
    }
    if err := tc.TrackUseCase.DeleteTrack(context.TODO(), idInt); err != nil {
        c.JSON(500, gin.H{
            "detail": fmt.Sprintf("Failed to delete track: %v", err),
        })
    } else {
        c.JSON(204, nil)
    }
}