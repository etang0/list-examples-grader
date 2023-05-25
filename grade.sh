CPATH='.:grading-area:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission

FILEPATH=$(find "student-submission" -name "*.java")
if ! [[ -e $FILEPATH ]]
    then
        echo "Submission does not exist"
        exit
fi

if ! [[ -f $FILEPATH ]]
    then
        echo "Submission is not a file"
        exit
fi

mv $FILEPATH grading-area

echo 'Finished cloning'

FILEPATH2=$(find "grading-area" -name "*.java")

javac $FILEPATH2
if [[ $? ]] 
then echo $FILEPATH2 compiled
else echo $FILEPATH2 failed to compile
fi

cp TestListExamples.java grading-area
javac -cp $CPATH grading-area/ListExamples.java grading-area/TestListExamples.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep -E "There was|) test" > feedback.txt
cat feedback.txt

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests