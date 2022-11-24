// 计算value值为数字的Map的value的总和
Integer totalCount = newTumorPatternMap.entrySet().stream().mapToInt(t->t.getValue()).sum();