#!/usr/bin/python
#
# 2020 06 21: Create QR-Codes for museum
#
# (c) phi
#


## install fpdf first:
## python -m pip install fpdf
from fpdf import FPDF;

## install python-mysql first:
## python -m pip install mysql-connector-python
import mysql.connector as mariadb;

## install qr-code first
## python -m pip install opencv-python qrcode
import qrcode;


## Create a temporary QR-Code PNG in /img/ folder.
##
def create_temp_qrCode(id):
	url = "https://bms.smoch.ch/erfindung.php/";
	filename = "img/" + str(id) + ".png";
	qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
	)
	qr.add_data(url + str( id));
	qr.make(fit=True);
	img = qr.make_image(fill_color="#000", back_color="#cf0");
	img.save(filename);

X_INDENT = 41;

global pdf;

## Handle a single "Exponat"
def print_single_exponat(exp, nrOnPage):
	ydelta = 80*(nrOnPage - 1);
	obererRand = 10;
	txtAlign   = 5;
	# add qr code		
	create_temp_qrCode(exp[0]);
	pdf.image("img/" + str(exp[0]) + ".png", 10, obererRand + ydelta, 40);

	# space for text
	pdf.y = ydelta + obererRand + txtAlign;
#	pdf.move(10, 20);
	#pdf.set_font("Courier", size=10);
	#pdf.cell(200, 36, txt="", ln=1, align="L");

  #texte
	pdf.set_font("Courier", size=9);
	##print(">>>>" + x[0] + "<<<");
	pdf.cell(X_INDENT);
	text = "bms.smoch.ch/erfindung.php/" + str(exp[0]);
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=12);
	pdf.cell(X_INDENT);
	pdf.set_text_color(80, 100, 0);
	text = "Erfindung: " + str(exp[1]) + " (" + str(exp[2]) + ")";
	pdf.cell(200, 6, txt=text, ln=1, align="L");
	pdf.set_text_color(0, 0, 0);
	
	pdf.set_font("times", size=11);
	pdf.cell(X_INDENT);
	text = "Exponat: " + str(exp[5]) + " (" + str(exp[4]) + ")";
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=10);
	pdf.cell(X_INDENT);
	text = "Kategorie: " + str(exp[9]);
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=9);
	pdf.cell(X_INDENT);
	text = "Inventar Nr: " + str(exp[6]);
	pdf.cell(200, 6, txt=text, ln=1, align="L");


	
## DB Connection

print("Start: connecting to db smoch (localhost)");
mydb = mariadb.connect(
  host    ="localhost",
  user    ="smoch"    ,
  password="123"      ,
  database="smoch"
);

mycursor = mydb.cursor();

mycursor.execute("SELECT * FROM `vw_erfindungsexponat`");

myresult = mycursor.fetchall();
print("DB read done");


# Create the pdf
print("Creating PDF...");
pdf = FPDF();

global qr_number;
qr_number = 1;

pdf.add_page();
for ex in myresult:
	qr_number;
	pdf;
	qr_codes_per_page = 3;
	qr_nr_on_actualPage = 1 + ((qr_number-1) % qr_codes_per_page);
	print_single_exponat(ex, qr_nr_on_actualPage);

	qr_number = qr_number + 1;
	
	if qr_codes_per_page == qr_nr_on_actualPage:
		pdf.add_page();

  

#STORE the PDF at the end
pdf.output("qr-codes.pdf");
print("... done [qr-codes.pdf created].");
