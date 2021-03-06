within TRANSFORM.Fluid.Examples.SteamRankine_BalanceOfPlant.Components;
partial model PartialRankine " Rankine cycle model"
  parameter Integer nbr_pumps_LP=3 "Number of low pressure feed-water pumps";
  parameter Integer nbr_pumps_HP=3 "Number of high pressure feed-water pumps";
  parameter Real eta_is_HPT=0.84 "Turbine isentropic efficiency";
  parameter Real eta_is_LPT=0.85 "Turbine isentropic efficiency";

  parameter Real eta_mech=0.99 "Turbine mechanical efficiency";
  replaceable package Medium =
      Modelica.Media.Water.StandardWater
    annotation (__Dymola_choicesAllMatching=true);

  parameter Records.RankineNominalValues nominalData "Nominal data"
    annotation (Dialog(group="Nominal operating data"), Placement(
        transformation(extent={{202,70},{222,90}})));
  parameter Records.RankineStartValues initData(
    p_start_turbine_HP_stage1_feed=nominalData.p_nom_turbine_HP_stage1_feed,
    p_start_turbine_HP_stage1_drain=nominalData.p_nom_turbine_HP_stage1_drain,
    p_start_turbine_LP_stage1_drain=nominalData.p_nom_turbine_LP_stage1_drain,
    p_start_turbine_LP_stage2_drain=nominalData.p_nom_turbine_LP_stage2_drain,
    p_start_condenser=nominalData.p_nom_condenser,
    p_start_feedWaterPump_drain=nominalData.p_nom_feedWaterPump_drain,
    p_start_preheater_LP=nominalData.p_nom_preheater_LP,
    p_start_preheater_HP=nominalData.p_nom_preheater_HP,
    T_start_turbine_HP_stage1_feed=nominalData.T_nom_turbine_HP_stage1_feed,
    T_start_turbine_HP_stage1_drain=nominalData.T_nom_turbine_HP_stage1_drain,
    T_start_turbine_IP_drain=nominalData.T_nom_turbine_LP_stage1_drain,
    p_start_dearator=nominalData.p_nom_dearator,
    T_start_turbine_LP_drain=nominalData.T_nom_turbine_LP_stage2_drain,
    p_start_preheater_HP_cooling_in=nominalData.p_nom_preheater_HP_cooling_in,
    p_start_preheater_HP_cooling_out=nominalData.p_nom_preheater_HP_cooling_out,
    T_start_preheater_HP_cooling_out=nominalData.T_nom_preheater_HP_cooling_out,
    p_start_to_SG_drain=nominalData.p_nom_to_SG_drain,
    p_start_turbine_LP_stage1_feed=nominalData.p_nom_turbine_LP_stage1_feed,
    T_start_turbine_LP_feed=nominalData.T_nom_turbine_LP_stage1_feed,
    p_start_turbine_HP_stage2_feed=nominalData.p_nom_turbine_HP_stage2_feed,
    p_start_turbine_HP_stage2_drain=nominalData.p_nom_turbine_HP_stage2_drain)
    "Initialization data" annotation (Dialog(group="Initialization"),
      Placement(transformation(extent={{229,70},{249,90}})));

  Interfaces.FluidPort_State feed_SG1(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-179,100},{-159,120}}),
        iconTransformation(extent={{-179,100},{-159,120}})));
  Interfaces.FluidPort_Flow drain_to_SG1(redeclare package Medium = Medium)
                       annotation (Placement(transformation(extent={{-179,-40},
            {-159,-20}}), iconTransformation(extent={{-179,-40},{-159,-20}})));

  Control.ControlBuses.ControlBus_Rankine controlBus
    annotation (Placement(transformation(extent={{17,-160},{57,-120}})));

  Interfaces.FluidPort_Flow drain_to_SG2(redeclare package Medium = Medium)
                       annotation (Placement(transformation(extent={{-179,-90},
            {-159,-70}}), iconTransformation(extent={{-179,-90},{-159,-70}})));
  Interfaces.FluidPort_Flow drain_to_SG3(redeclare package Medium = Medium)
                       annotation (Placement(transformation(extent={{-177,-141},
            {-157,-121}}), iconTransformation(extent={{-179,-140},{-159,-120}})));
  Interfaces.FluidPort_State feed_SG2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-180,58},{-160,78}}),
        iconTransformation(extent={{-180,58},{-160,78}})));
  Interfaces.FluidPort_State feed_SG3(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-180,15},{-160,35}}),
        iconTransformation(extent={{-180,20},{-160,40}})));
equation

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-170,
            -140},{250,100}},
        grid={1,1},
        initialScale=0.1)),                    Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-170,-140},{250,100}},
        grid={1,1},
        initialScale=0.1),
        graphics={
        Rectangle(
          extent={{-172,128},{256,-145}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-122,126},{161,109}},
          lineColor={0,0,0},
          textString="%name"),
        Rectangle(
          extent={{-15,13},{15,-13}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=1,
          origin={-45,-78},
          rotation=180),
        Rectangle(
          extent={{-13,11},{13,-11}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-45,-78},
          rotation=180),
        Polygon(
          points={{-52,41},{-52,35},{157,35},{157,41},{-52,41}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,63},{81,15}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=3),
        Rectangle(
          extent={{-40,62},{6,14}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=3),
        Polygon(
          points={{-11,9},{-11,-9},{11,-21},{11,21},{-11,9}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-17,37},
          rotation=360),
        Polygon(
          points={{-144,69},{-45,69},{-45,67},{-45,68},{-45,67},{-143,67},{-144,
              69}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-11,9},{-11,-9},{11,-21},{11,21},{-11,9}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={66,39},
          rotation=360),
        Rectangle(
          extent={{80,-1},{118,-31}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=3),
        Polygon(
          points={{86,-4},{86,-22},{92,-22},{92,-26},{108,-26},{108,-22},{114,
              -22},{114,-4},{86,-4}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{114,-8},{88,-8},{94,-14},{90,-20},{114,-20},{114,-18},{94,
              -18},{98,-14},{94,-10},{114,-10},{114,-8}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,-66},{52,-90}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=3),
        Rectangle(
          extent={{-4,-74},{48,-86}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          radius=10),
        Ellipse(
          extent={{30,-68},{12,-84}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{64,-66},{94,-92}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=1),
        Rectangle(
          extent={{66,-68},{92,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{64,-76},{64,-76}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{66,-78},{74,-78},{80,-70},{80,-84},{86,-78},{92,-78},{92,-80},
              {86,-80},{78,-88},{78,-76},{74,-80},{66,-80},{66,-78}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-13,1},{-5,1},{1,9},{1,-5},{7,1},{13,1},{13,-1},{7,-1},{-1,-9},
              {-1,3},{-5,-1},{-13,-1},{-13,1}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          origin={-44,-78},
          rotation=180),
        Polygon(
          points={{76,14},{76,6},{98,6},{98,0},{100,0},{100,8},{78,8},{78,14},{
              76,14}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{104,-30},{104,-34},{104,-80},{94,-80},{94,-78},{102,-78},{
              102,-30},{104,-30}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,-78},{50,-80},{66,-80},{66,-78},{50,-78}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{26,-90},{26,-102},{-21,-102},{-21,-78},{-19,-77},{-19,-100},
              {24,-100},{24,-90},{26,-90}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-77},{-19,-79}},
          lineColor={105,149,214},
          lineThickness=0.5,
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-159,-77},{-59,-79}},
          lineColor={105,149,214},
          lineThickness=0.5,
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,-49},{0,-49},{0,14},{-2,14},{-2,-47},{-44,-47},{-44,-49}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,1},{-15,1},{-15,-1},{-16,-1},{-15,-1},{-32,-1},{-32,1}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid,
          origin={-44,-32},
          rotation=90),
        Polygon(
          points={{79,-49},{48,-49},{48,14},{50,14},{50,-47},{79,-47},{79,-49}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,1},{-14,1},{-14,-1},{-14,-1},{-14,-1},{-32,-1},{-32,1}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid,
          origin={78,-34},
          rotation=90),
        Polygon(
          points={{11,9},{11,-9},{-11,-21},{-11,21},{11,9}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={41,39},
          rotation=360),
        Rectangle(
          extent={{92,63},{147,15}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=3),
        Polygon(
          points={{11,9},{11,-9},{-11,-21},{-11,21},{11,9}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={107,39},
          rotation=360),
        Polygon(
          points={{-11,9},{-11,-9},{11,-21},{11,21},{-11,9}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={132,39},
          rotation=360),
        Polygon(
          points={{129,14},{129,6},{107,6},{107,0},{105,0},{105,8},{127,8},{127,
              14},{129,14}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-13,11},{13,-11}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={13,81},
          rotation=180),
        Rectangle(
          extent={{-15,13},{15,-13}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid,
          radius=1,
          origin={25,81},
          rotation=180),
        Rectangle(
          extent={{-13,11},{13,-11}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={25,81},
          rotation=180),
        Polygon(
          points={{-13,1},{-5,1},{1,9},{1,-5},{7,1},{13,1},{13,-1},{7,-1},{-1,-9},
              {-1,3},{-5,-1},{-13,-1},{-13,1}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid,
          origin={26,80},
          rotation=180),
        Polygon(
          points={{-3,63},{-3,81},{10,81},{10,79},{-1,79},{-1,63},{-3,63}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,81},{54,81},{54,63},{52,63},{52,79},{40,79},{40,81}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{53,81},{120,81},{120,79},{120,81},{120,79},{53,79},{53,81}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{120,63},{120,81},{107,81},{107,79},{118,79},{118,63},{120,63}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,69},{-46,57},{-40,57},{-40,59},{-44,59},{-44,69},{-46,69}},
          lineColor={216,112,112},
          lineThickness=0.5,
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-75,-79},{-75,-132},{-159,-132},{-158,-129},{-78,-129},{-78,
              -78},{-75,-79}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-75,-77},{-75,-27},{-158,-27},{-157,-30},{-78,-30},{-78,-77},
              {-75,-77}},
          lineColor={105,149,214},
          fillColor={105,149,214},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-144,112},{-162,109}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-145,69},{-165,66}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-145,31},{-167,28}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-146,112},{-143,28}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{2,-8.5},{2,8.5},{7,8.5},{7,6.5},{4,6.5},{4,-8.5},{2,-8.5}},
          lineColor={216,112,112},
          fillColor={216,112,112},
          fillPattern=FillPattern.Solid,
          origin={18.5,101},
          rotation=270)}),
    Documentation(info="<html>
<h4>Description</h4>
<p>Example of a steam cycle configuration with reheat, two pre-heaters and one dearator.</p>
</html>",
      revisions="<html>
<!--copyright-->
</html>"));
end PartialRankine;
