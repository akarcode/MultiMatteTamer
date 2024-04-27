macroScript akarMultiMatteTamer
	category: "akar" 
	toolTip: "MultiMatte Tamer v1.2.2"
	Icon:#("Maxscript",1)
	ButtonText: "MMT"

(
global mmtForm (
	
	if mmtForm != undefined do mmtForm.close()
	
	pointClass = dotNetClass "System.Drawing.Point"
	sizeClass = dotNetClass "System.Drawing.Size"
	paddingClass = dotNetClass "System.Windows.Forms.Padding"
	colorClass = (dotNetClass "System.Drawing.Color").fromARGB
	
	colorRed = colorClass 135 100 100
	colorGreen = colorClass 100 135 100
	colorBlue = colorClass 100 100 135
	colorDefault = colorClass 100 100 100
	colorBorder = colorClass 85 85 85
	colorWhite = colorClass 255 255 255
	colorBlack = colorClass 0 0 0
	colorText = colorClass 185 185 185
	colorMouseOver = colorClass 56 56 56
	
	mmtForm = dotNetObject "maxCustomControls.MaxForm"
	mmtForm.Text = "akar \\\\ MultiMatte Tamer v1.2.2"
	mmtForm.Size = dotNetObject sizeClass 814 600
	mmtForm.MinimumSize = dotNetObject sizeClass 682 360
	mmtForm.StartPosition = mmtForm.StartPosition.CenterScreen
	mmtForm.autoScroll = false
	mmtForm.BackColor = colorClass 81 81 81
	
	collectCheckBox = dotNetObject "CheckBox"
	collectCheckBox.Location = dotNetObject pointClass 225 9
	collectCheckBox.Size = dotNetObject sizeClass 85 26
	collectCheckBox.ForeColor = colorText
	collectCheckBox.checked = false
	collectCheckBox.Text = "Collect"
	mmtForm.Controls.Add collectCheckBox
	
	selectedCheckBox = dotNetObject "CheckBox"
	selectedCheckBox.Location = dotNetObject pointClass 310 9
	selectedCheckBox.Size = dotNetObject sizeClass 97 26
	selectedCheckBox.ForeColor = colorText
	selectedCheckBox.checked = false
	selectedCheckBox.Text = "Selected"
	mmtForm.Controls.Add selectedCheckBox
	
	filterBackground = dotnetobject "FlowLayoutPanel"
	filterBackground.Location = dotNetObject pointClass 409 5
	filterBackground.Size = dotNetObject sizeClass 139 31
	filterBackground.Padding = dotNetObject paddingClass 2 2 0 0
	filterBackground.BackColor = colorWhite
	filterBackground.BorderStyle = filterBackground.BorderStyle.None
	mmtForm.Controls.Add filterBackground
	
	filterBorder = dotnetobject "FlowLayoutPanel"
	filterBorder.Location = dotNetObject pointClass 407 3
	filterBorder.Size = dotNetObject sizeClass 143 35
	filterBorder.BackColor = colorBorder
	filterBorder.BorderStyle = filterBorder.BorderStyle.None
	mmtForm.Controls.Add filterBorder
	
	filterTextBox = dotNetObject "TextBox"
	filterTextBox.Size = dotNetObject sizeClass 132 22
	filterTextBox.BorderStyle = filterTextBox.BorderStyle.None
	filterTextBox.AutoSize = false
	filterTextBox.BackColor = colorWhite
	filterBackground.Controls.Add filterTextBox
	
	flowPanel = dotnetobject "FlowLayoutPanel"
	flowPanel.Location = dotNetObject pointClass 0 38
	flowPanel.Size = dotNetObject sizeClass 792 0
	flowPanel.Anchor = dotNet.CombineEnums	flowPanel.Anchor.Top \
											flowPanel.Anchor.Left \
											flowPanel.Anchor.Right
	flowPanel.BackColor = colorClass 68 68 68
	flowPanel.AutoSize = true
	mmtForm.Controls.Add flowPanel
	
	addButton = dotNetObject "Button"
	addButton.Location = dotNetObject pointClass 2 3
	addButton.Size = dotNetObject sizeClass 106 35
	addButton.BackColor = colorDefault
	addButton.ForeColor = colorText
	addButton.FlatStyle = addButton.FlatStyle.Flat
	addButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	addButton.FlatAppearance.BorderColor = colorBorder
	addButton.FlatAppearance.BorderSize = 2
	addButton.Text = "Add Button"
	mmtForm.Controls.Add addButton

	refreshButton = dotNetObject "Button"
	refreshButton.Location = dotNetObject pointClass 110 3
	refreshButton.Size = dotNetObject sizeClass 106 35
	refreshButton.BackColor = colorDefault
	refreshButton.ForeColor = colorText
	refreshButton.FlatStyle = refreshButton.FlatStyle.Flat
	refreshButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	refreshButton.FlatAppearance.BorderColor = colorBorder
	refreshButton.FlatAppearance.BorderSize = 2
	refreshButton.Text = "Refresh"
	mmtForm.Controls.Add refreshButton
	
	elementButton = dotNetObject "Button"
	elementButton.Location = dotNetObject pointClass 684 3
	elementButton.Size = dotNetObject sizeClass 106 35
	elementButton.Anchor = dotNet.CombineEnums	elementButton.Anchor.Top \
												elementButton.Anchor.Right
	elementButton.BackColor = colorDefault
	elementButton.ForeColor = colorText
	elementButton.FlatStyle = elementButton.FlatStyle.Flat
	elementButton.FlatAppearance.MouseOverBackColor = colorMouseOver
	elementButton.FlatAppearance.BorderColor = colorBorder
	elementButton.FlatAppearance.BorderSize = 2
	elementButton.Text = "Elements"
	mmtForm.Controls.Add elementButton
	
	borderPanel = dotnetobject "Panel"
	borderPanel.Location = dotNetObject pointClass 2 77
	borderPanel.Size = dotNetObject sizeClass 788 423
	borderPanel.Anchor = dotNet.CombineEnums	borderPanel.Anchor.Top \
												borderPanel.Anchor.Bottom \
												borderPanel.Anchor.Left \
												borderPanel.Anchor.Right
	borderPanel.Padding = dotNetObject paddingClass 2
	borderPanel.BackColor = colorBorder
	mmtForm.Controls.Add borderPanel
	
	dataGrid = dotNetObject "DataGridView"
	dataGrid.BorderStyle = dataGrid.BorderStyle.None
	dataGrid.Dock = dataGrid.Dock.Fill
	dataGrid.RowHeadersVisible = false
	dataGrid.AutoSizeColumnsMode = dataGrid.AutoSizeColumnsMode.Fill
	dataGrid.AllowUserToResizeRows = false
	dataGrid.AllowUserToResizeColumns = true
	dataGrid.AllowUserToOrderColumns = false
	dataGrid.AllowUserToAddRows = false
	dataGrid.ColumnHeadersHeight = 34
	dataGrid.ColumnHeadersHeightSizeMode = dataGrid.ColumnHeadersHeightSizeMode.DisableResizing
	dataGrid.BackgroundColor = colorWhite
	dataGrid.ForeColor = colorBlack
	dataGrid.AlternatingRowsDefaultCellStyle.BackColor = colorClass 235 235 235
	dataGrid.DefaultCellStyle.SelectionBackColor = colorClass 130 130 130
	dataGrid.AlternatingRowsDefaultCellStyle.SelectionBackColor = colorClass 120 120 120
	dataGrid.ShowEditingIcon = false
	dataGrid.ReadOnly = true
	dataGrid.SelectionMode = dataGrid.SelectionMode.FullRowSelect
	
	bindingFlags = dotNet.combineEnums	(dotNetClass "System.Reflection.BindingFlags").Instance \
										(dotNetClass "System.Reflection.BindingFlags").NonPublic
	(((dataGrid.GetType()).GetProperty "DoubleBuffered" bindingFlags).SetValue dataGrid true)
	
	styleRed = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleRed.BackColor = colorClass 255 225 225
	styleRed.SelectionBackColor = colorClass 180 125 125
	styleRed.SelectionForeColor = colorWhite
	styleRed.Font = dataGrid.Font
	styleRedAlt = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleRedAlt.BackColor = colorClass 235 200 200
	styleRedAlt.SelectionBackColor = colorClass 170 115 115
	styleRedAlt.SelectionForeColor = colorWhite
	styleRedAlt.Font = dataGrid.Font
	
	styleGreen = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleGreen.BackColor = colorClass 225 255 225
	styleGreen.SelectionBackColor = colorClass 125 180 125
	styleGreen.SelectionForeColor = colorWhite
	styleGreen.Font = dataGrid.Font
	styleGreenAlt = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleGreenAlt.BackColor = colorClass 200 235 200
	styleGreenAlt.SelectionBackColor = colorClass 115 170 115
	styleGreenAlt.SelectionForeColor = colorWhite
	styleGreenAlt.Font = dataGrid.Font
	
	styleBlue = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleBlue.BackColor = colorClass 225 225 255
	styleBlue.SelectionBackColor = colorClass 125 125 180
	styleBlue.SelectionForeColor = colorWhite
	styleBlue.Font = dataGrid.Font
	styleBlueAlt = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleBlueAlt.BackColor = colorClass 200 200 235
	styleBlueAlt.SelectionBackColor = colorClass 115 115 170
	styleBlueAlt.SelectionForeColor = colorWhite
	styleBlueAlt.Font = dataGrid.Font
	
	styleNone = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleNone.BackColor = colorClass 255 255 255
	styleNone.SelectionBackColor = colorClass 130 130 130
	styleNone.SelectionForeColor = colorWhite
	styleNone.Font = dataGrid.Font
	styleNoneAlt = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
	styleNoneAlt.BackColor = colorClass 235 235 235
	styleNoneAlt.SelectionBackColor = colorClass 120 120 120
	styleNoneAlt.SelectionForeColor = colorWhite
	styleNoneAlt.Font = dataGrid.Font
	
	
	columnNames = #("Name", "Layer", "OID")
	
	for Names in columnNames do (
		
		Column = dotNetObject "DataGridViewTextBoxColumn"
		Column.HeaderText = Names
		Column.SortMode = Column.SortMode.Automatic
		
		if Names == "OID" do (
			
			Column.ValueType = dotNetClass "System.Int16"
			Column.AutoSizeMode = Column.AutoSizeMode.None
			Column.Width = 50
			
		)
		
		dataGrid.Columns.Add Column
		
	)

	borderPanel.Controls.Add dataGrid
	
	
	-- check if multimatte element is available and hide button if not
	fn checkMultiMatte = (
		
		re = maxOps.GetCurRenderElementMgr()

		try (
			
			re.addRenderElement (MultiMatteElement ElementName:("tamertest"))
				
			element = re.GetRenderElement (re.NumRenderElements() - 1)
			
			if classof element == MultiMatteElement and element.ElementName == "tamertest" do (
				
				re.RemoveRenderElement element
				
			)

		) catch (

			elementButton.Visible = false

		)
	)
	
	
	--select objects and renderable shapes
	fn getSelection = (
		
		choiceSelection = objects
		if selectedCheckBox.checked == true then (
			
			choiceSelection = selection
		
		)
		
		objectSelection = for o in choiceSelection 	where ((superclassof o == shape \
													and o.render_renderable == true) \
													or superclassof o == GeometryClass \
													and classof o != Targetobject \
													and classof o != VRayDecal \
													and classof o != VRayClipper \
													and o.ishidden != true \
													) collect o
		
		objectSelection
		
	)

	
	fn checkUsed value = (
		
		result = false
		for i in getSelection() do (
			
			if i.gbufferChannel == value do (
				
				result = true
				exit
				
			)
		)
		
		result
		
	)
	
	
	fn colorButton value = (
		
		if value == 0 then (
			
			colorDefault
			
		) else if int(mod value 3) == 0 then (
			
			colorBlue
			
		) else if int(mod (value + 1) 3) == 0 then (
			
			colorGreen
			
		) else (
			
			colorRed
			
		)
	)
	
	
	fn refreshGrid = (
		
		for i in getSelection() do (
			
			Row = dotNetObject "DataGridViewRow"
			dataGrid.Rows.Add Row
			
			Row.Cells.Item[0].Value = i.Name
			Row.Cells.Item[1].Value = i.Layer.Name
			Row.Cells.Item[2].Value = i.gbufferChannel
			
		)
	)
	
	
	fn setCellColor sender args = (
		
		if args.columnIndex == 2 and collectCheckBox.checked then (
			
			if flowPanel.Controls.Item[args.Value].BackColor.B == 135 then (
				
				-- Blue
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleBlue
				
				) else (
					
					args.CellStyle = styleBlueAlt
					
				)
			) else if flowPanel.Controls.Item[args.Value].BackColor.G == 135 then (
				
				-- Green
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleGreen
				
				) else (
					
					args.CellStyle = styleGreenAlt
					
				)
			) else if flowPanel.Controls.Item[args.Value].BackColor.R == 135 then (
				
				-- Red
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleRed
				
				) else (
					
					args.CellStyle = styleRedAlt
					
				)
			) else (
				
				-- Neutral
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleNone
					
				) else (
					
					args.CellStyle = styleNoneAlt
					
				)
			)
		) else if args.columnIndex == 2 and not collectCheckBox.checked then (
			
			if args.Value == 0 then (
				
				-- Neutral
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleNone
					
				) else (
					
					args.CellStyle = styleNoneAlt
					
				)
 			) else if int(mod args.Value 3) == 0 then (
				
				-- Blue
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleBlue
				
				) else (
					
					args.CellStyle = styleBlueAlt
					
				)
			) else if int(mod (args.Value + 1) 3) == 0 then (
				
				-- Green
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleGreen
				
				) else (
					
					args.CellStyle = styleGreenAlt
					
				)
			) else (
				
				-- Red
				if int(mod args.RowIndex 2) == 0 then (
					
					args.CellStyle = styleRed
				
				) else (
					
					args.CellStyle = styleRedAlt
					
				)
			)
		)
	)
	
	
	fn colorizeButtons = (
		
		if collectCheckBox.checked == false then (
			
			-- 0 is skipped in the loop and needs to be set separately
			if checkUsed 0 == true then (
				
				flowPanel.Controls.Item[0].FlatAppearance.BorderColor = colorWhite
				
			) else (
				
				flowPanel.Controls.Item[0].FlatAppearance.BorderColor = colorBorder
				
			)
			
			colorArray = #(colorRed, colorGreen, colorBlue)
			
			for i = 1 to (flowPanel.Controls.Count - 1) by 3 do (
				
				for col in colorArray do (
					
					flowPanel.Controls.Item[i].BackColor = col
					
					if checkUsed(i) == true then (
					
						flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorWhite
						
					) else (
						
						flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorder
						
					)
					
					-- avoid overshooting the loop
					if i < (flowPanel.Controls.Count - 1) then (
						
						i += 1
						
					) else (
						
						exit
						
					)
				)
			)
		) else (
			
			usedCounter = 0
			-- avoid having the first id after 0 not to be checked as 0 in selection mode
			if checkUsed 0 == false do (
				
				usedCounter = 1

			)
			
			for i = 0 to (flowPanel.Controls.Count - 1) do (
				
				if checkUsed(i) == true then (
					
					flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorWhite
					flowPanel.Controls.Item[i].BackColor = colorButton usedCounter
					usedCounter += 1 

				) else (
					
					flowPanel.Controls.Item[i].FlatAppearance.BorderColor = colorBorder
					flowPanel.Controls.Item[i].BackColor = colorDefault
					
				)
			)
		)
		
		dataGrid.InvalidateColumn 2
		
	)

	
	fn resizeEvent = (

		mmtForm.MinimumSize = dotNetObject sizeClass 682 (dataGrid.Location.Y + 420)
		borderPanel.Height = (mmtForm.Height - flowPanel.Size.Height - 96)
		borderPanel.Location = dotNetObject pointClass 2 (flowPanel.Size.Height + 38)
		
	)
	

	fn checkButton sender args = (
		
		for i = 0 to dataGrid.SelectedRows.count - 1 do (
			
			index = (dataGrid.SelectedRows.Item[i].Index)
			
			(getNodeByName dataGrid.Rows.Item[index].Cells.Item[0].Value).gbufferChannel = sender.Name as integer
			dataGrid.Rows.Item[index].Cells.Item[2].Value = sender.Name as integer
			
		)
		
		colorizeButtons()
		
	)
	
	
	fn findHighest = (
		
		value = 0
		for i in getSelection() do (
			
			if i.gbufferChannel > value do (
				
				value = i.gbufferChannel
				
			)
		)
		
		if value < 9 do (
			
			value = 9
			
		)
		
		value
		
	)


	fn createButton value = (
		
		colorize = false
		if value == unsupplied do (
			
			value = flowPanel.Controls.Count
			colorize = true
			
		)
		
		newButton = dotNetObject "Button"
		newButton.BackColor = colorDefault
		newButton.FlatAppearance.BorderColor = colorBorder
		newButton.BackColor = colorDefault
		newButton.Size = dotNetObject sizeClass 40 35
		newButton.ForeColor = colorWhite
		newButton.FlatStyle = newButton.FlatStyle.Flat
		newButton.FlatAppearance.MouseOverBackColor = colorMouseOver
		newButton.FlatAppearance.BorderSize = 2
		newButton.Margin = dotNetObject paddingClass 2
		newButton.Padding = dotNetObject paddingClass 0
		newButton.Text = (value as string)
		newButton.Name = (value as string)
		flowPanel.Controls.Add newButton
		dotNet.AddEventHandler newButton "Click" checkButton
		dotNet.SetLifeTimeControl newButton #dotNet
		
		if colorize == true do (
			
			colorizeButtons()
			
		)
		
		resizeEvent()
		
	)
	
	
	fn refreshAll = (
		
		dataGrid.Rows.Clear()
		
		-- check if a new higher ID has been created
		currentOID = flowPanel.Controls.Count
		highestOID = findHighest()
		
		if currentOID == highestOID then (
			
			createButton highestOID
			
		) else if currentOID < highestOID do (
			
			for i = currentOID to highestOID do (
				
				createButton i
				
			)
		)
		
		refreshGrid()
		colorizeButtons()
		
	)
	
	
	fn createElements = (
		
		re = maxOps.GetCurRenderElementMgr()

		-- remove all multimatte elements that include the name OID
		if (re.NumRenderElements()) != 0 do (
			
			for value in (re.NumRenderElements() - 1) to 0 by -1 do (
				
				element = re.GetRenderElement value
				
				if classof element == MultiMatteElement and matchpattern element.ElementName pattern:"*OID*" do (
					
					re.RemoveRenderElement element
					
				)
			)
		)
		
		
		elementArray = #()
		for i = 1 to (flowPanel.Controls.Count - 1) do (
			
			if flowPanel.Controls.Item[i].FlatAppearance.BorderColor.R == 255 do (
			
				append elementArray (flowPanel.Controls.Item[i].Name as integer)
			
			)
		)
		
		
		if collectCheckBox.checked == false then (
			
			for id in elementArray do (
					
				-- Blue
				if int(mod id 3) == 0 then (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + ((id / 3) as string)))
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + ((id / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + ((id / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.B_gbufID = id
					
					-- disable R and G if they are not present
					if not flowPanel.Controls.Item[id - 1].FlatAppearance.BorderColor.R == 255 do (
						
						element.G_gbufID = 0
						element.G_gbufIDOn = false
						
					)
					
					if not flowPanel.Controls.Item[id - 2].FlatAppearance.BorderColor.R == 255 do (
						
						element.R_gbufID = 0
						element.R_gbufIDOn = false
						
					)
					
				-- Green
				) else if int(mod (id + 1) 3) == 0 then (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 1) / 3) as string)))
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + (((id + 1) / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 1) / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.G_gbufID = id
					
					-- disable R and B if they are not present
					if not flowPanel.Controls.Item[id - 1].FlatAppearance.BorderColor.R == 255 do (
						
						element.R_gbufID = 0
						element.R_gbufIDOn = false
						
					)
					
					if id + 1 > flowPanel.Controls.Count - 1 \
					or not flowPanel.Controls.Item[id + 1].FlatAppearance.BorderColor.R == 255 \
					do (
						
						element.B_gbufID = 0
						element.B_gbufIDOn = false
						
					)
					
				-- Red
				) else (
					
					if (re.NumRenderElements()) == 0 then (
						
						re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 2) / 3) as string)))
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						
					) else (
							
						element = re.GetRenderElement (re.NumRenderElements() - 1)
						if element.ElementName != ("OID" + (((id + 2) / 3) as string)) then (
							
							re.addRenderElement (MultiMatteElement elementname:("OID" + (((id + 2) / 3) as string)))
							element = re.GetRenderElement (re.NumRenderElements() - 1)
								
						)
					)
					
					element.R_gbufID = id
					
					-- disable G and B if they are not present
					if id + 1 > flowPanel.Controls.Count - 1 \
					or not flowPanel.Controls.Item[id + 1].FlatAppearance.BorderColor.R == 255 \
					do (
						
						element.G_gbufID = 0
						element.G_gbufIDOn = false
						
					)
					
					if id + 2 > flowPanel.Controls.Count - 1 \
					or not flowPanel.Controls.Item[id + 2].FlatAppearance.BorderColor.R == 255 \
					do (
						
						element.B_gbufID = 0
						element.B_gbufIDOn = false
						
					)
				)
			) 
		) else (
			
			mmeName = 1
			
			for i = 1 to elementArray.Count by 3 do (
				
				re.addRenderElement (MultiMatteElement ElementName:("OID" + (mmeName as string)))
				element = re.GetRenderElement (re.NumRenderElements() - 1)
				
				-- Red
				element.R_gbufID = elementArray[i]
				
				-- Green
				if i + 1 <= elementArray.Count then (
				
					element.G_gbufID = elementArray[i + 1]
					
				) else (
					
					element.G_gbufID = 0
					element.G_gbufIDOn = false
					
				)
				
				-- Blue
				if i + 2 <= elementArray.Count then (
				
					element.B_gbufID = elementArray[i + 2]
					
				) else (
					
					element.B_gbufID = 0
					element.B_gbufIDOn = false
					
				)
				
				if i < elementArray.Count then (
					
					mmeName += 1
					
				) else (
					
					exit
					
				)
			)
		)
	)
	
	
	fn selectFilter sender args = (
		
		dataGrid.ClearSelection()

		Regex = dotNetObject "System.Text.RegularExpressions.Regex" ("\W*(" + sender.Text + ")\W*")
		
		if sender.Text != "" then (
			
			for i = 0 to (dataGrid.Rows.Count - 1) do (
				
				if (Regex.IsMatch dataGrid.Rows.Item[i].Cells.Item[0].Value) do (
					
					dataGrid.Rows.Item[i].Selected = true
				
				)
			)
		) else (
			
			dataGrid.ClearSelection()
			
		)
	)
	
	
	fn selectRelated sender args = (
		
		if args.RowIndex != -1 and args.ColumnIndex == 0 do (
			
			Regex = dotNetObject "System.Text.RegularExpressions.Regex" "\d+$"
			
			if (Regex.IsMatch dataGrid.Rows.Item[args.RowIndex].Cells.Item[0].Value) do (
				
				targetName = Regex.Replace dataGrid.Rows.Item[args.RowIndex].Cells.Item[0].Value ""
				targetLayer = dataGrid.Rows.Item[args.RowIndex].Cells.Item[1].Value
				
				if targetName.Count >= 1 do (
					
					for i = 0 to (dataGrid.Rows.Count - 1) do (
						
						if	(Regex.IsMatch dataGrid.Rows.Item[i].Cells.Item[0].Value) \
						and (Regex.Replace dataGrid.Rows.Item[i].Cells.Item[0].Value "") == targetName \
						and (dataGrid.Rows.Item[i].Cells.Item[1].Value) == targetLayer \
						do (
							
							dataGrid.Rows.Item[i].Selected = true
							
						)
					)
				)
			)
		)
			
		if args.RowIndex != -1 and args.ColumnIndex == 1 do (
			
			targetName = dataGrid.Rows.Item[args.RowIndex].Cells.Item[1].Value
			
			for i = 0 to (dataGrid.Rows.Count - 1) do (
				
				if dataGrid.Rows.Item[i].Cells.Item[1].Value == targetName do (
					
					dataGrid.Rows.Item[i].Selected = true
				
				)
			)
		)
		
		if args.RowIndex != -1 and args.ColumnIndex == 2 do (
			
			targetNumber = dataGrid.Rows.Item[args.RowIndex].Cells.Item[2].Value
			
			for i = 0 to (dataGrid.Rows.Count - 1) do (
				
				if dataGrid.Rows.Item[i].Cells.Item[2].Value == targetNumber do (
					
					dataGrid.Rows.Item[i].Selected = true
				
				)
			)
		)
	)
	
	
	dotNet.AddEventHandler dataGrid "CellFormatting" setCellColor
	dotNet.AddEventHandler dataGrid "CellDoubleClick" selectRelated
	dotNet.AddEventHandler collectCheckBox #CheckStateChanged colorizeButtons
	dotNet.AddEventHandler selectedCheckBox #CheckStateChanged refreshAll
	dotNet.AddEventHandler filterTextBox "TextChanged" selectFilter
	dotNet.AddEventHandler mmtForm #Resize resizeEvent
	dotNet.AddEventHandler addButton "Click" (fn _ = createButton unsupplied)
	dotNet.AddEventHandler filterBackground "Click" (fn _ = filterTextBox.Focus())
	dotNet.AddEventHandler refreshButton "Click" refreshAll
	dotNet.AddEventHandler elementButton "Click" createElements
	
	-- avoid that events get garbage collected and lose reference to the script values
	dotNet.SetLifeTimeControl collectCheckBox #dotNet
	dotNet.SetLifeTimeControl selectedCheckBox #dotNet
	dotNet.SetLifeTimeControl mmtForm #dotNet
	dotNet.SetLifeTimeControl addButton #dotNet
	dotNet.SetLifeTimeControl refreshButton #dotNet
	dotNet.SetLifeTimeControl elementButton #dotNet
	
	--add first buttons
	for i = 0 to findHighest() do (
		
		createButton i
		
	)
	
	refreshGrid()
	colorizeButtons()
	flowPanel.Focus()
	checkMultiMatte()
	mmtForm.showModeless()
	
)
)
