# Aria2c-File-Downloader
Here’s a simple and clear README for your script:

---

This Bash script downloads files from a list of URLs provided in a `urls.txt` file. It uses `aria2c`for downloads and organizes the files into a specified directory.

---

## Prerequisites

1. Bash
2. `aria2c`
3. dos2unix

---

## Setup

1. Clone or copy the script to your system.
2. make sure the script is executable:
   ```bash
   chmod +x downloader.sh
   ```

3. Create a `urls.txt` file in the same directory as the script. Add one URL per line:
   ```
   https://example.com/file1.zip
   https://example.com/file2.zip
   ```

---

## Usage

Run the script using:
```bash
./downloader.sh
```

---

## changing stuff

- Save directory: Change the `SAVE_DIR` variable in the script to use a different folder:
  ```bash
  SAVE_DIR="my_custom_folder"
  ```

-  Concurrency: Modify the `-x` flag in the `aria2c` command to adjust the number of connections:
  ```bash
  aria2c -x 8  # Use 8 connections instead of 16
  ```
