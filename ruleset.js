const lines = $files[0].split('\n');
const rules = {
  domain: [],
  domain_suffix: [],
  domain_keyword: [],
  ip_cidr: []
};

lines.forEach(line => {
  let trimmedLine = line.trim();
  // 跳过空行或注释行
  if (!trimmedLine || trimmedLine.startsWith('#') || trimmedLine.startsWith('//')) {
    return;
  }

  const parts = trimmedLine.split(',');
  const type = parts[0];
  const value = parts[1];

  // 根据规则类型分配到相应的数组
  switch (type) {
    case 'DOMAIN':
      rules.domain.push(value);
      break;
    case 'DOMAIN-SUFFIX':
      rules.domain_suffix.push(value);
      break;
    case 'DOMAIN-KEYWORD':
      rules.domain_keyword.push(value);
      break;
    case 'IP-CIDR':
    case 'IP-CIDR6':
      rules.ip_cidr.push(value);
      break;
    default:
      // 如果是不带逗号的情况，处理 domain-set 格式
      if (!trimmedLine.includes(',')) {
        if (trimmedLine.startsWith('.')) {
          rules.domain_suffix.push(trimmedLine);
        } else {
          rules.domain.push(trimmedLine);
        }
      }
      break;
  }
});

const singBox = {
  version: 1,
  rules: [{}]
};
Object.keys(rules).forEach(key => {
  if (rules[key].length > 0) {
    singBox.rules[0][key] = rules[key];
  }
});

$content = JSON.stringify(singBox, null, 2);
