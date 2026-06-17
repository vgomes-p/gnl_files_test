# GNL FILES TESTER

## How to use
### 1. Clone repo, copy the file to your gnl directory
```bash
git clone https://github.com/vgomes-p/gnl_files_test.git
```
```bash
cp -r [this file path]/* [dest file path]
```

### 2. compile
```bash
make
```

### 3. Run the program with or without flag and passing the file to read path
> without flag only print the file's content
```bash
./gnl_tester files/test3
```

> with flag print the file's content and count lines
```bash
./gnl_tester files/pray_to_god --cnt
```