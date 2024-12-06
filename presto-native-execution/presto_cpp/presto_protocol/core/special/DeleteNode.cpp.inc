/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
namespace facebook::presto::protocol {
DeleteNode::DeleteNode() noexcept {
  _type = "com.facebook.presto.spi.plan.DeleteNode";
}

void to_json(json& j, const DeleteNode& p) {
  j = json::object();
  j["@type"] = "com.facebook.presto.spi.plan.DeleteNode";
  to_json_key(j, "id", p.id, "DeleteNode", "PlanNodeId", "id");
  to_json_key(j, "source", p.source, "DeleteNode", "PlanNode", "source");
  to_json_key(
      j,
      "rowId",
      p.rowId,
      "DeleteNode",
      "VariableReferenceExpression",
      "rowId");
  to_json_key(
      j,
      "outputVariables",
      p.outputVariables,
      "DeleteNode",
      "List<VariableReferenceExpression>",
      "outputVariables");
  to_json_key(
      j,
      "inputDistribution",
      p.inputDistribution,
      "DeleteNode",
      "InputDistribution",
      "inputDistribution");
}

void from_json(const json& j, DeleteNode& p) {
  p._type = j["@type"];
  from_json_key(j, "id", p.id, "DeleteNode", "PlanNodeId", "id");
  from_json_key(j, "source", p.source, "DeleteNode", "PlanNode", "source");
  from_json_key(
      j,
      "rowId",
      p.rowId,
      "DeleteNode",
      "VariableReferenceExpression",
      "rowId");
  from_json_key(
      j,
      "outputVariables",
      p.outputVariables,
      "DeleteNode",
      "List<VariableReferenceExpression>",
      "outputVariables");
  from_json_key(
      j,
      "inputDistribution",
      p.inputDistribution,
      "DeleteNode",
      "InputDistribution",
      "inputDistribution");
}
} // namespace facebook::presto::protocol
