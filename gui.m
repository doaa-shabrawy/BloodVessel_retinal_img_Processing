function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 05-May-2022 16:02:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Loud_image.
function Loud_image_Callback(hObject, eventdata, handles)
% hObject    handle to Loud_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im im2 
[path,user_cancel]= imgetfile();
if user_cancel
    msgbox(sprintf('Invalied selection', 'Error','Warn'));
    return
end

im= imread(path);
im=im2double(im);
im2=im;
axes (handles.axes1);
imshow(im),title(' retina image')


% 
% % --- Executes on button press in Filter.
% function Filter_Callback(hObject, eventdata, handles)
% % hObject    handle to Filter (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% global im 
% axes (handles.axes2);
% ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
% ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
% LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
% fill = cat(3,1,0,0);
% FilledImg = bsxfun(@times, fill, LabImg);
% ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
% [cof,score]= pca(ReshapedLImg);
% score = reshape(score , size(LabImg));
% score = score(: ,: ,1);
% GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
% EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
% AvgFilter = fspecial('average',[9 9]);% فلتر 
% FilteredImg = imfilter(EnhancedImg,AvgFilter);
% 
% imshow(FilteredImg),title("Filtered Image");







% --- Executes on button press in binary_image.
function binary_image_Callback(hObject, eventdata, handles)
% hObject    handle to binary_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im 
axes (handles.axes3);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

SubstructedImg = imsubtract(FilteredImg,EnhancedImg);

level = thresholdLevel(SubstructedImg);
BinaryImg = im2bw(SubstructedImg,level-0.008);
imshow(BinaryImg),title('Binary Image');

% --- Executes on button press in clean_img.
function clean_img_Callback(hObject, eventdata, handles)
% hObject    handle to clean_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im 
axes (handles.axes4);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

SubstructedImg = imsubtract(FilteredImg,EnhancedImg);

level = thresholdLevel(SubstructedImg);
BinaryImg = im2bw(SubstructedImg,level-0.008);
CleanImg = bwareaopen(BinaryImg,100);
imshow(CleanImg),title('Cleaned Image');

% --- Executes on button press in complemented_image.
function complemented_image_Callback(hObject, eventdata, handles)
% hObject    handle to complemented_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im 
axes (handles.axes5);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

SubstructedImg = imsubtract(FilteredImg,EnhancedImg);

level = thresholdLevel(SubstructedImg);
BinaryImg = im2bw(SubstructedImg,level-0.008);
CleanImg = bwareaopen(BinaryImg,100);
ComplementedImg = imcomplement(CleanImg);
imshow(ComplementedImg),title('Complemented Image');

% --- Executes on button press in final_image.
function final_image_Callback(hObject, eventdata, handles)
% hObject    handle to final_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im 
axes (handles.axes6);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

SubstructedImg = imsubtract(FilteredImg,EnhancedImg);

level = thresholdLevel(SubstructedImg);
BinaryImg = im2bw(SubstructedImg,level-0.008);
CleanImg = bwareaopen(BinaryImg,100);
ComplementedImg = imcomplement(CleanImg);
Final_resultImg = colorizeImage(ResizedImg,ComplementedImg,[0 0 0]);
imshow(Final_resultImg),title('Final Image');


% --------------------------------------------------------------------
function authors_Callback(hObject, eventdata, handles)
% hObject    handle to authors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf('Names:\n Tasniem Seiam \n Aya Shehata \n Menna Hisham \n Doaa Mostafa \n Aya Mohamed', 'Author'));


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im 
axes (handles.axes2);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[3 3]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

imshow(FilteredImg),title("Filtered 3x3 Image");


% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im 
axes (handles.axes2);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

imshow(FilteredImg),title("Filtered 9x9 Image");

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im 
axes (handles.axes2);
ResizedImg = imresize(im,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);
AvgFilter = fspecial('average',[5 5]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

imshow(FilteredImg),title("Filtered 5x5 Image");


% Hint: get(hObject,'Value') returns toggle state of radiobutton4
