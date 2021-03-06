within TRANSFORM.Fluid.ClosureRelations.PumpCharacteristics.Models;
partial model PartialCharacteristic

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component" annotation (Dialog(tab="Internal Interface"));

  input Medium.ThermodynamicState state "Thermodynamic state"
    annotation (Dialog(tab="Internal Interface", group="Input Variables"));

  input SI.VolumeFlowRate V_flow(start=V_flow_start) "Mass flow rate"
    annotation (Dialog(tab="Internal Interface", group="Input Variables"));
  input SI.Conversions.NonSIunits.AngularVelocity_rpm N "Pump speed"
    annotation (Dialog(tab="Internal Interface", group="Input Variables"));
  input SI.Length diameter "Impeller Diameter"
    annotation (Dialog(tab="Internal Interface", group="Input Variables"));

  parameter SI.Conversions.NonSIunits.AngularVelocity_rpm N_nominal
    "Pump speed" annotation (Dialog(tab="Internal Interface", group="Nominal Operating Parameters"));
  parameter SI.Length diameter_nominal "Impeller Diameter" annotation (Dialog(
        tab="Internal Interface", group="Nominal Operating Parameters"));
  parameter SI.VolumeFlowRate V_flow_nominal "Nominal volumetric flow rate"
    annotation (Dialog(tab="Internal Interface", group="Nominal Operating Parameters"));
  parameter SI.VolumeFlowRate V_flow_start
    annotation (Dialog(tab="Internal Interface", group="Initialization"));

  Units.nonDim affinityLaw "Affinity law for scaling";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialCharacteristic;
