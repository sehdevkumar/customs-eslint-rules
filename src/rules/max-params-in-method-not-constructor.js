module.exports = {
  create(context) {
    return {
      ArrowFunctionExpression(node) {
        if (node.params.length > 7) {
          context.report({
            node,
            message: `Too many parameters in this ${
              'Arrow Function'
            }. Maximum allowed: ${7}.`,
          });
        }
      },
      MethodDefinition(node) {
        if (node.kind === "constructor") {
          if (node.value.params.length > 10) {
            context.report({
              node,
              message: `Too many parameters in this ${
                node.kind
              }. Maximum allowed: ${10}.`,
            });
          }
        } else {
          if (node.value.params.length > 7) {
            context.report({
              node,
              message: `Too many parameters in this ${
                node.kind
              }. Maximum allowed: ${7}.`,
            });
          }
        }
      },
    };
  },
};
