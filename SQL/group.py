import os

# Specify the folder containing the files
source_folder = "SQL/TableCreationCommands"  # Replace with the folder path
output_file = "combinedSql.sql"   # The file to write all contents into

# Open the output file in write mode
with open(output_file, mode="w", encoding="utf-8") as outfile:
    # Iterate through all files in the folder
    for filename in os.listdir(source_folder):
        file_path = os.path.join(source_folder, filename)
        
        # Check if it's a file (not a folder)
        if os.path.isfile(file_path):
            with open(file_path, mode="r", encoding="utf-8") as infile:
                # Write the content of the file into the output file
                outfile.write(f"--- Content of {filename} ---\n")  # Optional: add a header for each file
                outfile.write(infile.read() + "\n\n")  # Read and append content with spacing
                print(f"Added content from {filename}")
