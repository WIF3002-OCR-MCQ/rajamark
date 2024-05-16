<h1>RajaMark User Manual Documentation</h1>

  <details>
    <summary>Table of Contents</summary>
    <ol>
      <li><a href="#10-introduction">Introduction</a></li>
      <li><a href="#20-getting-started">Getting Started</a></li>
      <li><a href="#30-features">Features</a></li>
      <li><a href="#40-troubleshooting">Troubleshooting</a></li>
      <li><a href="#50-best-practices">Best Practices</a></li>
      <li><a href="#60-glossary">Glossary</a></li>
      <li><a href="#70-appendix">Appendix</a></li>
    </ol>
  </details>

---

## 1.0 Introduction
<p align="justify">Meet RajaMark, your reliable helper to automate the grading of multiple-choice question (MCQ)
answer sheets. By leveraging Tesseract OCR for handwritten text recognition and OpenCV for
image preprocessing, RajaMark can swiftly and accurately interpret handwritten answers (A-E)
beside question numbers. This automation eliminates the tedious and error-prone manual grading
process, making it ideal for educational institutions seeking a more efficient grading solution.</p>

<p align="justify">In addition to grading, RajaMark offers tools to compile class results, allowing educators to
aggregate individual scores and generate comprehensive reports on class performance in quizzes
and tests. This feature helps teachers quickly identify trends and areas for improvement,
streamlining the assessment process. Overall, RajaMark is a valuable resource for schools and
universities aiming to improve the speed and accuracy of MCQ evaluation while reducing the
workload on educators.</p>

---

## 2.0 Getting Started
### 2.1 Operating System Requirements
RajaMark requires (either one):
- the 64-bit version of Microsoft Windows 10 or later. These versions of Windows should
include the required Windows PowerShell 5 or later.
- ChromeOS.

### 2.2 Installation Steps
To install RajaMark:
1. Click [here]("#") to access our Google Drive.
2. Download the .exe file.
3. Click the .exe file and allow it to make changes to your computer for execution.
4. You are all set.

### 2.3 Account Setup
#### 2.3.1 Register
1. Upon first launch into the system, you will be asked to enter your email and password to
log into your existing account in the Login page. 
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/0083c541-2b5d-4729-95fd-4b4ffae688f5">
</p>

2. If you have not set up an account before, click the “Don’t have an account? Register
here” button. If you have already registered an account, go to Login.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/82ce7b0b-d653-4229-b260-7d64f16b563c">
</p>

3. You will be asked to give your email and password that you intend to use. Upon
completing the registration, you will have to enter your password once again for
confirmation.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/ccb467b7-2a0a-4b4b-b5cf-46789b86b8fa">
</p>

4. Click the “Register” button once you have filled in the required information for
registration.

5. You will be redirected to the Login if you have registered successfully.


#### 2.3.2 Login
1. In the Login page, fill in your email or username and password then click on the “Log in”
button.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/28689eb7-dc23-4e6d-88e5-513f91d92440">
</p>

2. If you have forgotten your password and wish to create a new one, proceed to Forgot
Password.

#### 2.3.3 Forgot Password
1. Click on the “Forgot Password?” button.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/82ce7b0b-d653-4229-b260-7d64f16b563c">
</p>

2. Enter your registered email address to receive a password reset link to change your
password.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/eee030ba-bdb2-4ea2-bab3-8069be1b1460">
</p>

3. You will be shown with this message if you have entered a valid email address.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/03b4fbd0-a99f-471f-b6ed-da9cb6cf7f0a">
</p>

#### 2.3.4 Logout
1. After successfully logged in, you will now see the Homepage (dashboard page) like the
picture below:
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/47767192-0e4b-4d4f-8a90-b56ec0c38d1e">
</p>

2. If you wish to log out, navigate to the navigation bar located at the leftmost of the screen
and click on the “LogOut” button. You will then be redirected to the Login page again.

### 2.4 Navigation

<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/e3aa6264-99ac-4142-8254-c11b9b48664a">
</p>

1. Exam Page
<p align="justify">The Exam Page contains all exams that have been created. The exams can be edited or
deleted from this table. The date of creation will also be displayed on this page. It is also
possible to create a new exam from this page.</p>
   
2. Account Page
<p align="justify">The Account Page will display the user’s information. Users will also be able to check
and manage their account subscription on this page.</p>

3. User Manual Page
<p align="justify">The User Manual Page contains the documentation of the user manual that provides
detailed instructions on how to use this system effectively.</p>

4. LogOut
<p align="justify">Navigate to the navigation bar located at the leftmost of the screen and click on the
“LogOut” button if you wish to log out from your account.</p>

---

## 3.0 Features
### 3.1 Exam Creation
1. Go to the Exam page.
2. Click on the “Create” button to create a new examination/quiz.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/EC1.png">
</p>

3. Enter the examination’s details and grading’s criteria.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/EC2.png">
</p>

4. Scroll down to enter the answer scheme.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/EC3.png">
</p>

5. Click the “save” button to create the examination record.
6. The examination record is successfully created.

### 3.2 Edit Examination
1. Go to the Exam page.
2. Click on the “edit” icon for the specific exam to be edited.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/EE1.png">
</p>

3. Enter the changes required in the Edit Exam page.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/EE2.png">
</p>

4. Scroll down and click the “save” button to apply the changes.

### 3.3 View Exam's details
1. Go to the Exam page.
2. Click on the “eye” icon for a specific exam to view the exam’s details.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/VED1.png">
</p>

3. You will be directed to the Exam Details page.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/VED2.png">
</p>

### 3.4 Manage student's answer
1. Go to the Exam page.
2. Click on the “eye” icon to view the exam’s details.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/MSA1.png">
</p>

3. Once redirected into the Exam Details page, navigate to the list of students’ records and
click on the “eye” icon to view the student’s details, “note” icon to edit the student's
details or “trash” icon to delete the student's information.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/MSA2.png">
</p>

4. On the Student’s Details page, make the changes and click the “Save” button to save changes to the student's answer.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/8765cac70fa1d55e58d26b3d627bcffbae285707/rajamarkapp/Images/MSA3.png">
</p>

### 3.5 Upload Sample Answer
1. Go to the Exam page.
2. Click on the “eye” icon to view the exam’s details.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/8b829546-ae1c-48f5-80f6-f87baab31e05">
</p>

3. Click on the “Upload answer” button to upload the sample answer scheme.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/d9d340ef-261f-4fc0-a508-e5b5487d2dfe">
</p>

4. Once redirected into the Answer Scheme page, click the “+” icon to upload the sample
answer scheme.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/f4f83d47-6321-4625-a0be-edf910094112">
</p>

5. Upload the answer scheme file.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/e53cdced-958a-45dc-bfcd-fe5155346ac9">
</p>

6. If the image processing fails, try to upload another file with a clearer view of the answer
scheme.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/82aa0872-9b38-4b45-94a8-9749ea16d870)">
</p>

7. Wait for the file to be processed.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/07f73b2b-f513-4091-a564-f1c52757625c">
</p>
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/bc6b42f4-cb63-4022-9eab-f11b133800ef">
</p>

8. Click the “confirm” button to apply the answer scheme.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/5b8ad11d-13a4-4b71-868d-382c5799013b">
</p>

### 3.6 Upload Student Answer
1. Go to the Exam page.
2. Select the “eye icon” of the exam you wish to grade.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA2.png">
</p>

3. Click the “View Answer” button at the top right corner. 
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA3.png">
</p>
4. Click the "+" button to upload the student's answer sheet.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA4.png">
</p>
5. After selecting a file, the system will automatically extract the data from the image. (Please refer to Best Practices to learn more about the guidelines for uploading the answer sheet)
<p></p>
6. The extracted student's answer sheet will be displayed.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA6.png">
</p>

#### 6.1 If the user wants to edit the answer sheet.
6.1.1 Click the pen icon to edit.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA6.1.1.png">
</p>
6.1.2 Modify the answer sheet and click on the save button to save the changes made.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA6.1.2.png">

#### 6.2 If the user wants to delete the record: 
6.2.1 Click on the trash icon.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA6.2.1.png">
</p>
6.2.2 A confirmation dialog will be shown.
<p align="center">
  <img width="60%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/blob/9d7069b81541027fa16fc51b3e4946ec6ceecf97/rajamarkapp/Images/USA6.2.2.png">

7. Repeat steps 4 to 6 to add more students as necessary.


---

## 4.0 Troubleshooting
### 4.1 Common Issues
<table align="center">
  <thead>
    <tr>
      <th>NO</th>
      <th>Issues</th>
      <th>Issue Description</th>
      <th>Solution</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Poor Image Quality</td>
      <td align="justify">OCR accuracy may decrease if the input images are of low
resolution or contain artifacts such as blurriness or distortion.</td>
      <td align="justify">Ensure that input images are clear, well-lit, and have
sufficient resolution. Avoid using images with excessive noise or compression artifacts.</td>
    </tr>
    <tr>
      <td>2</td>
      <td>Unsupported Fonts</td>
      <td align="justify">Certain fonts or styles may not be recognized accurately by the
OCR system, leading to errors in text extraction.</td>
      <td align="justify">Whenever possible, use standard fonts and avoid decorative or obscure fonts
that may not be recognized reliably by the OCR system.</td>
    </tr>
    <tr>
      <td>3</td>
      <td>Complex Layouts</td>
      <td align="justify">Documents with complex layouts, such as tables, columns, or mixed fonts, can
pose challenges for OCR algorithms and result in incorrect text extraction.</td>
      <td align="justify">If possible, preprocess documents to remove complex layouts or convert
them into simpler formats before performing OCR. This can help improve accuracy and reduce errors.</td>
    </tr>
    <tr>
      <td>4</td>
      <td>Handwritten Text</td>
      <td align="justify">Our product is encountering difficulties accurately recognizing handwritten text</td>
      <td align="justify">For handwritten text, please ensure that the handwriting is clear and legible, and that
the document is properly scanned or photographed for optimal results.</td>
    </tr>
  </tbody>
</table>

### 4.2 Support Contact
<p align="justify">If you encounter any issues with the OCR system that cannot be resolved using the provided
solutions, please contact our support team for assistance:</p>
<p>Email: [spqprojectmanager@gmail.com](spqprojectmanager@gmail.com)</p>

---

## 5.0 Best Practices
### 5.1 Grading Tips
1. Ensure students format answers consistently and legibly to aid OCR accuracy.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/94b5a288-465d-4c08-9dd1-e049bdbaf3f7">
</p>

2. Advise clear separation of answers for each question to minimize ambiguity.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/4f3991b5-38f0-49f4-997e-fe8690089e31">
</p>

3. Caution against overlapping answers to enhance OCR interpretation.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/b571b39a-d102-407f-b5c0-0eabfb1a4f67">
</p>

4. Scan answers at high resolution in well-lit conditions for optimal recognition.
5. Encourage manual review of extracted text for clarity before submission.
6. Ensure students use dark, bold pens or pencils for writing to improve OCR readability.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/85174803-2eaa-41de-a491-3dcb6072e277">
</p>

7. Remind students to avoid excessive use of decorative elements or symbols that may
interfere with OCR recognition.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/2a9bc8fc-ff90-44c1-aa21-f0606b4b39c5">
</p>

8. Provide guidelines for students to write numbers and symbols clearly, especially those
prone to misinterpretation
9. Advise against folding or creasing answer sheets, as it can distort text and hinder OCR
accuracy.
10. Recommend students to use a ruler or straight edge for neat alignment of answers to
improve OCR alignment.
<p align="center">
  <img width="40%" src="https://github.com/WIF3002-OCR-MCQ/rajamark/assets/117422678/d883fc15-0c17-4c09-b5e8-e6d7a40761d7">
</p>

### Accuracy Recommendations
1. Provide clear handwriting guidelines to optimize OCR recognition; for example, require
all multiple-choice answers to be in capital letters.
2. Conduct regular practice sessions to familiarize students with handwriting recognition
and improve their writing.
3. Offer constructive feedback to students to enhance handwriting quality and OCR
accuracy.
4. Provide comprehensive user training to educators to address accuracy challenges
effectively.
5. Develop a standardized answer sheet template with clear instructions and designated
areas for answers to facilitate OCR processing.
6. Encourage students to practice writing in a consistent style and size to aid OCR
recognition.

---

## 6.0 Glossary
<table align="center">
  <thead>
    <tr>
      <th>Term</th>
      <th>Definition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Optical Character Recognition (OCR)</td>
      <td align="justify">The technology used to convert different types of documents, such as scanned
  paper documents, PDF files, or images captured by a digital camera, into
  editable and searchable data.</td>
    </tr>
    <tr>
      <td>Resolution</td>
      <td align="justify">The level of detail that an image holds. In the context of scanning, it measures
the number of pixels per inch (PPI) or dots per inch (DPI) in a digital image.</td>
    </tr>
    <tr>
      <td>Layout</td>
      <td align="justify">The arrangement of text, images, and other elements on a document or
webpage.</td>
    </tr>
    <tr>
      <td>Handwriting Recognition</td>
      <td align="justify">The process of converting handwritten text into digital text. It involves
analyzing and interpreting handwritten characters to recognize and convert
them into machine-readable text.</td>
    </tr>
    <tr>
      <td>Calibration</td>
      <td align="justify">The process of adjusting and fine-tuning equipment or software to ensure
accuracy and consistency in performance. In the context of scanning,
calibration may involve adjusting settings such as brightness, contrast, and
color balance to optimize image quality.</td>
    </tr>
    <tr>
      <td>Standardized Format</td>
      <td align="justify">A predefined layout or structure that follows specific guidelines or
conventions. In the context of answer sheets, a standardized format ensures
consistency in the presentation of questions and answers, facilitating accurate
interpretation and grading.</td>
    </tr>
    <tr>
      <td>Alignment</td>
      <td align="justify">The positioning of text or objects relative to a reference point or line. In the
context of OCR, alignment ensures that text is accurately detected and
interpreted within predefined boundaries or regions.</td>
    </tr>
    <tr>
      <td>Noise</td>
      <td align="justify">Random variations or interference in an image that can degrade quality and
affect OCR accuracy.</td>
    </tr>
    <tr>
      <td>Preprocessing</td>
      <td align="justify">The process of applying various techniques to raw data, such as images or text,
to improve quality, enhance features, or prepare it for further analysis.</td>
    </tr>
  </tbody>
</table>

---

## 7.0 Appendix
### 7.1 Frequently Asked Questions
**1. Which platforms are RajaMark compatible with?**
<p align="justify">
  A: RajaMark is designed to be compatible with multiple operating systems, which are
Windows, macOS, Linux, Android and iOS.
</p>

**2. How does RajaMark automate answer sheet grading?**
<p align="justify">
  A: RajaMark assumes the adherence of the answer sheets uploaded to a standardized
format and layout, and conducts recognition of students’ handwriting with OCR
technology to compare the answers with the sample provided.
</p>

**3. What format should the answer sheets uploaded be in?**
<p align="justify">
  A: The answer sheets should have the answers consistently written next to the
corresponding question numbers in a predetermined manner and written in Capital
Letters (e.g., letters A-E)
</p>

**4. How does RajaMark ensure its accuracy in text recognition to compare uploaded
answer sheets with the sample answers?**
<p align="justify">
  A: While we try our best to produce the most accurate text recognition results using OCR
technology, it is inevitable to face minor inaccuracies in detecting the handwritten
answers. Hence, we highly advise users to conduct a thorough checking of the graded
answers and make the necessary corrections on the Student Answer Page.
</p>

**5. Can I modify the grading system for a subject?**
<p align="justify">
  A: Yes! After the user has created a subject under the Exam Details page, a default grade
will be automatically set for the subject and users can click “Edit” to amend the existing
grading system.
</p>
