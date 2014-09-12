var colorImgCanvas = document.getElementById('colorImgCanvas');
var grayscaleImgCanvas = document.getElementById('grayscaleImgCanvas');

var img = new Image();
img.src = 'lenna256.jpg';

var AkColorImg = AkLoadImage(img,1);
var AkGrayscaleImg = AkLoadImage(img,1);

for (var i = 0; i < AkGrayscaleImg.width; i++) {
    for (var j = 0; j < AkGrayscaleImg.height; j++) {
        var r = AkGet(AkGrayscaleImg, i, j, 0),
            g = AkGet(AkGrayscaleImg, i, j, 1),
            b = AkGet(AkGrayscaleImg, i, j, 2);

        var avg = (r + g + b) / 3;

        AkSet(AkGrayscaleImg, i, j, 0, avg);
        AkSet(AkGrayscaleImg, i, j, 1, avg);
        AkSet(AkGrayscaleImg, i, j, 2, avg);
    }
}

AkLoadOnCanvas(AkColorImg, colorImgCanvas);
AkLoadOnCanvas(AkGrayscaleImg, grayscaleImgCanvas);
