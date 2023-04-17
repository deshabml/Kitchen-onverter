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
    @Published var typeMeasuringSystemPicker: TypeMeasuringSystem = TypeMeasuringSystem(name: "Вес", isWeight: true)
    @Published var typeMeasuringSystem: [TypeMeasuringSystem] = [TypeMeasuringSystem(name: "Вес", isWeight: true),
                                                                 TypeMeasuringSystem(name: "Объём", isWeight: false)]
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
        viewModel.savingMeasuringSystem(measuringSystem: MeasuringSystem(name: measuringSystemsName, isWeight: typeMeasuringSystemPicker.isWeight, ratio: measuringSystemsRatio))
    }

    func checkMeasuringSystem() throws {
        guard !measuringSystemsName.isEmpty else { throw MeasuringSystemError.emptyName }
        guard measuringSystemsName.count <= 7 else { throw MeasuringSystemError.longName }
        guard !measuringSystemsRatio.isEmpty else { throw MeasuringSystemError.emptyRatio }
        guard let _ = Double(measuringSystemsRatio) else { throw MeasuringSystemError.ratioNotDouble }
    }

}
