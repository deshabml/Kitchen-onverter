//
//  AddMeasuringSystemViewModel.swift
//  KitchenСonverter
//
//  Created by Лаборатория on 15.04.2023.
//

import Foundation

enum MeasuringSystemError: Error {

    case emptyName
    case longName
    case emptyRatio
    case ratioNotDouble

}

class AddMeasuringSystemViewModel: ObservableObject  {

    @Published var measuringSystemsName: String = ""
    @Published var measuringSystemsRatio: String = ""
    @Published var measuringSystem: MeasuringSystem?
    @Published var typeMeasuringSystemPicker: TypeMeasuringSystem = RealmService.shared.getTypeMeasuringSystem()[0]
    @Published var typeMeasuringSystem: [TypeMeasuringSystem] = RealmService.shared.getTypeMeasuringSystem()
    var textEnterЕheRatio: String {
        typeMeasuringSystemPicker.isWeight ? "Сколько грамм" : "Сколько миллилитров"
    }
    var errorMasege: String {
        do {
            try checkMeasuringSystem()
        } catch MeasuringSystemError.emptyName {
            return "Поле название единицы измерения пустое!"
        } catch MeasuringSystemError.emptyRatio {
            return "Поле соотношение пустое!"
        } catch MeasuringSystemError.ratioNotDouble {
            return "Соотношение должно быть числом!"
        } catch MeasuringSystemError.longName {
            return "Название единицы измерения слишком длинное (до 7 букв)"
        } catch {
            return "Что то пошло не так."
        }
        return ""
    }

    func addMeasuringSystem(viewModel: MainViewModel) {
        guard let measuringSystemsRatio = Double(measuringSystemsRatio) else { return }
        viewModel.savingObject(object: MeasuringSystem(name: measuringSystemsName, isWeight: typeMeasuringSystemPicker.isWeight, ratio: measuringSystemsRatio))
    }

    func checkMeasuringSystem() throws {
        guard !measuringSystemsName.isEmpty else { throw MeasuringSystemError.emptyName }
        guard measuringSystemsName.count <= 7 else { throw MeasuringSystemError.longName }
        guard !measuringSystemsRatio.isEmpty else { throw MeasuringSystemError.emptyRatio }
        guard let _ = Double(measuringSystemsRatio) else { throw MeasuringSystemError.ratioNotDouble }
    }

}

extension AddMeasuringSystemViewModel {

    func getData(viewModel: MainViewModel) {
        measuringSystem = viewModel.measuringSystemPickerSecond
        guard let measuringSystem = measuringSystem else { return }
        measuringSystemsName = measuringSystem.name
        measuringSystemsRatio = "\(measuringSystem.ratio)"
        typeMeasuringSystemPicker = measuringSystem.isWeight ? typeMeasuringSystem[0] : typeMeasuringSystem[1]
    }

    func updateMeasuringSystem(viewModel: MainViewModel) {
        guard let measuringSystemsRatio = Double(measuringSystemsRatio) else { return }
        guard let measuringSystem = measuringSystem else { return }
        viewModel.updateObject(oldObject: measuringSystem, newObject: MeasuringSystem(name: measuringSystemsName, isWeight: typeMeasuringSystemPicker.isWeight, ratio: measuringSystemsRatio))
    }

    func deleteMeasuringSystem(viewModel: MainViewModel) {
        guard let measuringSystem = measuringSystem else { return }
        viewModel.deleteObject(object: measuringSystem)
        viewModel.measuringSystemPickerFirst = RealmService.shared.getMeasuringSystem()[0]
        viewModel.measuringSystemPickerSecond = RealmService.shared.getMeasuringSystem()[0]
    }

}


