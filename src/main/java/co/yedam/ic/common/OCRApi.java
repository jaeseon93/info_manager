package co.yedam.ic.common;

import com.google.cloud.vision.v1.*;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.protobuf.ByteString;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class OCRApi{

	public static void AuthCheck(){
		// Instantiates a client
		try(ImageAnnotatorClient vision = ImageAnnotatorClient.create()){

			// The path to the image file to annotate
			String fileName = "wakeupcat.png";

			// Reads the image file into memory
			Path path = Paths.get(fileName);
			byte[] data = Files.readAllBytes(path);
			ByteString imgBytes = ByteString.copyFrom(data);

			// Builds the image annotation request
			List<AnnotateImageRequest> requests = new ArrayList<>();
			Image img = Image.newBuilder().setContent(imgBytes).build();
			Feature feat = Feature.newBuilder().setType(Type.LABEL_DETECTION).build();
			AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			requests.add(request);

			// Performs label detection on the image file
			BatchAnnotateImagesResponse response = vision.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for(AnnotateImageResponse res : responses){
				if(res.hasError()){
					System.out.printf("Error: %s\n", res.getError().getMessage());
					return;
				}

				for(EntityAnnotation annotation : res.getLabelAnnotationsList()){
					annotation.getAllFields().forEach((k, v) -> System.out.printf("%s : %s\n", k, v.toString()));
				}
			}
		}catch(IOException e){
			e.printStackTrace();
		}
	}

	public static ArrayList<String> detectText(String filePath){
		List<AnnotateImageRequest> requests = new ArrayList<>();
		ArrayList<String> textList = new ArrayList<String>();
		ByteString imgBytes = null;
		try{
			imgBytes = ByteString.readFrom(new FileInputStream(filePath));
		}catch(IOException e){
			e.printStackTrace();
			return textList;
		}

		Image img = Image.newBuilder().setContent(imgBytes).build();
		Feature feat = Feature.newBuilder().setType(Type.TEXT_DETECTION).build();
		AnnotateImageRequest request =
				AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				if (res.hasError()) {
					System.out.printf("Error: %s\n", res.getError().getMessage());
					continue;
				}

				// For full list of available annotations, see http://g.co/cloud/vision/docs
				for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
					//textList.add(annotation.getDescription());

					//System.out.printf("Text: %s\n", annotation.getDescription());
					//System.out.printf("Position : %s\n", annotation.getBoundingPoly());
				}
				textList.add( res.getFullTextAnnotation().getText()) ;
			}
		}catch(IOException e){
			e.printStackTrace();
		}

		return textList;
	}
}

