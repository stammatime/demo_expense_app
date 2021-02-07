flutter build web --web-renderer canvaskit;
aws s3 rm s3://flutter-expense-tracker --recursive;
aws s3 cp build/web s3://flutter-expense-tracker/ --recursive;