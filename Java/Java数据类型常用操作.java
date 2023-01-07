########################################################@################ Array ##############################################################################
# 过滤数组中无效数据
Arrays.stream(allDataArray).filter(val -> !val.isNaN());
########################################################@################ Array ##############################################################################



########################################################@################ List ##############################################################################
// 根据子元素的某一值进行分组
Map<Integer, List<R2Info>> listMap = r2List.stream().collect(Collectors.groupingBy(R2Info::getStart));
########################################################@################ List ##############################################################################



########################################################@################ Map ##############################################################################
// 按某种规则对Map的键进行排序
List<Map.Entry<String, List<Integer>>> cpgPosListMapList = new ArrayList<Map.Entry<String, List<Integer>>>(cpgPosListMapRaw.entrySet());
cpgPosListMapList.sort(new Comparator<Map.Entry<String, List<Integer>>>() {
    public int compare(Map.Entry<String, List<Integer>> o1, Map.Entry<String, List<Integer>> o2) {
        String chromNum1 = o1.getKey().substring(3, o1.getKey().length());
        String chromNum2 = o2.getKey().substring(3, o2.getKey().length());
        if (util.isNumeric(chromNum1) && util.isNumeric(chromNum2)) {
            return Integer.valueOf(chromNum1) - Integer.valueOf(chromNum2);//o1减o2是升序，反之是降序
        } else {
            return chromNum1.compareTo(chromNum2);
        }
    }
});

// 计算value值为数字的Map的value的总和
Integer totalCount = newTumorPatternMap.entrySet().stream().mapToInt(t->t.getValue()).sum();
########################################################@################ Map ##############################################################################