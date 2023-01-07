// 打印处理进度
long totalCnt = Files.lines(scBedFile.toPath()).count(); // get the total lines of file
long completeCnt= 0l;
while ((scBedLine = bufferedReader.readLine()) != null) {
    completeCnt++;
    if (completeCnt % (totalCnt / 10) == 0) {
        int percent = (int) Math.round(Double.valueOf(completeCnt) * 100 / totalCnt );
        log.info("Complete " + percent + "%.");
    }
}