CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

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
echo $FILEPATH2

javac $FILEPATH2
if [[ $? ]] 
then echo $FILEPATH2 compiled
else echo $FILEPATH2 failed to compile
fi

javac -cp .:libs/junit-4.13.2.jar:libs/hamcrest-core-1.3.jar
if [[ $? ]] 
then echo junit compiled
else echo junit failed to compile
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests