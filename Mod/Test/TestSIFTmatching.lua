--[[
Title: TestSIFT
Author(s): BerryZSZ
Date: 2017/8/4
Desc: 
use the lib:
------------------------------------------------------------
NPL.load("(gl)Mod/ImagesTo3Dmodel/imP.lua",true);
NPL.load("(gl)Mod/ImagesTo3Dmodel/SIFT.lua",true);
NPL.load("(gl)Mod/Test/TestSIFTmatching.lua",true);
------------------------------------------------------------
]]

NPL.load("(gl)Mod/ImagesTo3Dmodel/imP.lua", true);
NPL.load("(gl)Mod/ImagesTo3Dmodel/SIFT.lua", true);

local zeros = imP.tensor.zeros;
local zeros3 = imP.tensor.zeros3;
local Round = imP.Round;
local imread = imP.imread;
local rgb2gray = imP.rgb2gray;
local CreatTXT = imP.CreatTXT;
local DotProduct = imP.tensor.DotProduct;
local ArraySum = imP.tensor.ArraySum;
local ArrayShow = imP.tensor.ArrayShow;
local ArrayShow3 = imP.tensor.ArrayShow3;
local ArrayMult = imP.tensor.ArrayMult;
local ArrayAdd = imP.tensor.ArrayAdd;
local ArrayAddArray = imP.tensor.ArrayAddArray;
local FindMax2 = imP.tensor.FindMax2;
local FindMin2 = imP.tensor.FindMin2;
local FindMax3 = imP.tensor.FindMax3;
local FindMin3 = imP.tensor.FindMin3;
local GetGaussian = imP.GetGaussian;
local GaussianF = imP.GaussianF;
local DoG = imP.DoG;
local meshgrid = imP.tensor.meshgrid;
local conv2 = imP.tensor.conv2;
local Det2 = imP.tensor.Det2;
local Trace2 = imP.tensor.Trace2;
local HarrisCD = imP.HarrisCD;
local GetColumn = imP.tensor.GetColumn;
local MatrixMultiple = imP.tensor.MatrixMultiple;
local det = imP.tensor.det;
local SubMartrix = imP.tensor.SubMartrix;
local inv = imP.tensor.inv;
local find = imP.tensor.find;
local subvector = imP.tensor.subvector;
local submatrix = imP.tensor.submatrix;
local connect = imP.tensor.connect;
local reshape = imP.tensor.reshape;
local transposition = imP.tensor.transposition;
local norm = imP.tensor.norm;
local dot = imP.tensor.dot;
local mod = imP.tensor.mod;
local Spline = imP.tensor.Spline;
local imresize = imP.tensor.imresize;

local HalfSize = SIFT.HalfSize;
local DoubleSize = SIFT.DoubleSize;
local gaussian = SIFT.gaussian;
local diffofg = SIFT.diffofg;
local localmax = SIFT.localmax;
local extrafine = SIFT.extrafine;
local orientation = SIFT.orientation;
local descriptor = SIFT.descriptor;
local DO_SIFT = SIFT.DO_SIFT;
local match = SIFT.match;
--
--local Im1_filename = "Mod/ImagesTo3Dmodel/demo-data/1.JPG";
--local Im2_filename = "Mod/ImagesTo3Dmodel/demo-data/2.JPG";

local Im1_filename = "Mod/ImagesTo3Dmodel/demo-data/fountain/1.jpg";
local Im2_filename = "Mod/ImagesTo3Dmodel/demo-data/fountain/2.jpg";

local TXT1_filename = "Mod/ImagesTo3Dmodel/1.txt";
local TXT2_filename = "Mod/ImagesTo3Dmodel/2.txt";


local Im1 = imread(Im1_filename);
local Im2 = imread(Im2_filename);

local I1 = rgb2gray(Im1);
local I2 = rgb2gray(Im2);


--LOG.std(nil, "debug", "SIFT", "Imresizing...")
local I_O1 = imresize(I1, 500 / math.min(#I1, #I1[1]));
local I_O2 = imresize(I2, 500 / math.min(#I2, #I2[1]));

--CreatTXT(I_O1, TXT1_filename);
--CreatTXT(I_O2, TXT2_filename);


local frames1, descr1, gss1, dogss1 = DO_SIFT(I_O1);
local frames2, descr2, gss2, dogss2 = DO_SIFT(I_O2);

--LOG.std(nil, "debug", "SIFT", "Computing matches...")


--CreatTXT(frames1, TXT1_filename);
--CreatTXT(frames2, TXT2_filename);
descr1 = transposition(descr1);
descr2 = transposition(descr2);

frames1 = transposition(frames1);
frames2 = transposition(frames2);

local final_matches, matches, num, loc1, loc2, loc1_new, loc2_new = match(I_O1, descr1, frames1, I_O2, descr2, frames2, 0.75);
LOG.std(nil, "debug", "SIFT", "Matched points:# %f", final_matches);
--LOG.std(nil, "debug", "SIFT", "Matched points:# %f", matches);
--LOG.std(nil, "debug", "SIFT", "Matched points:# %f", num);



local loc1_filename = "Mod/ImagesTo3Dmodel/3.txt";
local loc2_filename = "Mod/ImagesTo3Dmodel/4.txt";
local loc3_filename = "Mod/ImagesTo3Dmodel/5.txt";
local loc4_filename = "Mod/ImagesTo3Dmodel/6.txt";


--CreatTXT(loc1, loc1_filename);
--CreatTXT(loc2, loc2_filename);
--CreatTXT(loc1_new, loc3_filename);
--CreatTXT(loc2_new, loc4_filename);