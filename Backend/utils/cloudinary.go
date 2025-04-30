package utils

import (
	"context"
	"log"
	"mime/multipart"
	"os"
	"path/filepath"

	"github.com/cloudinary/cloudinary-go/v2"

	"github.com/cloudinary/cloudinary-go/v2/api/uploader"
)

var (
	cloudinaryURL = "cloudinary://792377839957387:TGv0-xMnEMvvaynYkNsOQzBmQcU@djcel1cai"
)

func UploadToCloudinary(file *multipart.FileHeader) (string, error) {

	localPath := "assets/uploads/" + file.Filename
	if err := os.MkdirAll(filepath.Dir(localPath), os.ModePerm); err != nil {
		return "", err
	}
	if err := saveFileLocally(file, localPath); err != nil {
		return "", err
	}
	defer os.Remove(localPath)

	cld, err := cloudinary.NewFromURL(cloudinaryURL)
	if err != nil {
		return "", err
	}

	ctx := context.Background()
	publicID := "user_profile_" + file.Filename
	resp, err := cld.Upload.Upload(ctx, localPath, uploader.UploadParams{PublicID: publicID})
	if err != nil {
		log.Println("Cloudinary upload failed:", err)
		return "", err
	}

	return resp.SecureURL, nil
}

func saveFileLocally(file *multipart.FileHeader, path string) error {
	src, err := file.Open()
	if err != nil {
		return err
	}
	defer src.Close()

	dst, err := os.Create(path)
	if err != nil {
		return err
	}
	defer dst.Close()

	_, err = dst.ReadFrom(src)
	return err
}
