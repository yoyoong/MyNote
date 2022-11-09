// 根据子元素的某一值进行分组
Map<Integer, List<R2Info>> listMap = r2List.stream().collect(Collectors.groupingBy(R2Info::getStart));
